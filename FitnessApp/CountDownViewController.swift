//
//  CountDownViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-12-02.
//

import UIKit
import AVKit
import AVFoundation

class CountDownViewController: UIViewController {
    var alertController: UIAlertController?
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var countDown = CountDown()
    
    var isPlaying: Bool = false {
        didSet {
            playPauseButton.isSelected = isPlaying
        }
    }
    
    @IBOutlet var roundsLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var countDownLabel: UILabel!
    @IBOutlet var remainingTimeLabel: UILabel!
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var playPauseButton: UIButton!
    
    var countDownMinutes: String = "00"
    var countDownSeconds: String = "00"
    
    var remainingTimer = Timer()
    var mainTimer = Timer()
    
    var initialWorkSeconds: Int = 0
    var initialRestSeconds: Int = 0
    var totalRounds: Int = 0
    var currentRound: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialWorkSeconds = countDown.workSecondsUnit
        initialRestSeconds = countDown.restSecondsUnit
        totalRounds = countDown.rounds
        
        updateUI()
    }
    
    @IBAction func playPuaseButtonTapped(_ sender: UIButton) {
        isPlaying.toggle()
        if isPlaying {
            remainingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                // remaining time
                self.countDown.remainingTime -= 1
                self.remainingTimeLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.remainingTime)
                
                if self.countDown.remainingTime == 0 {
                    timer.invalidate()
                }
                
            }
            // main count down
            self.countDownTimer()
        } else {
            remainingTimer.invalidate()
            mainTimer.invalidate()
        }
    }
    @IBAction func resetButtonTapped(_ sender: Any) {
        remainingTimer.invalidate()
        mainTimer.invalidate()

        initializeTimer()
    }
    
    func initializeTimer() {
        isPlaying = false
        self.countDown.rounds = totalRounds
        currentRound = 1
        countDown.CalculateSeconds()
        updateUI()
    }
    func updateUI() {
        countDownLabel.textColor = .label
        roundsLabel.text = "Round \(currentRound) / \(totalRounds)"
        if countDown.warmUp.minutes > 0 || countDown.warmUp.seconds > 0 {
            statusLabel.text = "Warm Up"
            countDownLabel.text = countDown.printMinutesSeconds(minutes: countDown.warmUp.minutes, seconds: countDown.warmUp.seconds)
        } else if countDown.work.minutes > 0 || countDown.work.seconds > 0 {
            statusLabel.text = "Work"
            countDownLabel.text = countDown.printMinutesSeconds(minutes: countDown.work.minutes, seconds: countDown.work.seconds)
        } else {
            statusLabel.text = "No Work"
            countDownLabel.text = "00:00"
        }
        
        remainingTimeLabel.text = countDown.printMinutesSeconds(minutes: Int(countDown.remainingTime / 60), seconds: Int(countDown.remainingTime % 60))
        totalTimeLabel.text = countDown.printMinutesSeconds(minutes: Int(countDown.totalSeconds / 60), seconds: Int(countDown.totalSeconds % 60))
    }
    func countDownTimer() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countDown.warmUpSeconds > 0 {
                self.countDown.warmUpSeconds -= 1
                self.countDownLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.warmUpSeconds)
                self.statusLabel.text = "Warm Up"
                if self.countDown.warmUpSeconds < 4 {
                    self.countDownLabel.textColor = .red
                }
                if self.countDown.warmUpSeconds == 0 {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    self.countDownLabel.textColor = .label
                    self.speech("Start")
                    self.showAlertMsg("Start Work")
                }
            } else if self.countDown.workSecondsUnit > 0 {
                self.countDown.workSecondsUnit -= 1
                self.countDownLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.workSecondsUnit)
                self.statusLabel.text = "Work"
                if self.countDown.workSecondsUnit < 4 {
                    self.countDownLabel.textColor = .red
                }
                if self.countDown.workSecondsUnit == 0 {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    self.countDownLabel.textColor = .label
                    self.showAlertMsg("Finish Work")
                    if(self.countDown.rounds > 1) {
                        self.speech("Rest")
                    } else {
                        self.speech("Cool Down")
                    }
                }
            } else if self.countDown.restSecondsUnit > 0 {
                self.countDown.restSecondsUnit -= 1
                self.countDownLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.restSecondsUnit)
                self.statusLabel.text = "Rest"
                if self.countDown.restSecondsUnit < 4 {
                    self.countDownLabel.textColor = .red
                }
                // next round
                if self.countDown.restSecondsUnit == 0 {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    self.countDownLabel.textColor = .label
                    self.showAlertMsg("Start Work")
                    self.speech("Start")
                    if self.countDown.rounds > 1 {
                        self.countDown.rounds -= 1
                        self.currentRound += 1
                        self.roundsLabel.text = "Round \(self.currentRound) / \(self.totalRounds)"
                        self.countDown.workSecondsUnit = self.initialWorkSeconds
                        // the last round doesn't have rest
                        if self.countDown.rounds > 1 {
                            self.countDown.restSecondsUnit = self.initialRestSeconds
                        }
                    }
                }
            } else if self.countDown.coolDownSeconds > 0 {
                self.countDown.coolDownSeconds -= 1
                self.countDownLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.coolDownSeconds)
                self.statusLabel.text = "Cool Down"
                if self.countDown.coolDownSeconds == 0 {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    self.showAlertMsg("Done")
                    self.speech("Done")
                }
            } else {
                timer.invalidate()
                self.initializeTimer()
            }
        }
    }
    
    func showAlertMsg(_ title: String) {
        guard self.alertController == nil else {
            print("Alert alreay displayed")
            return
        }
        
        self.alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        self.present(self.alertController!, animated: true, completion: nil)
        
        // dismiss programmatically after two seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.alertController!.dismiss(animated: true, completion: nil)
            self.alertController = nil
        })
    }
    
    func speech(_ speak: String) {
        let utterance = AVSpeechUtterance(string: speak)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        self.speechSynthesizer.speak(utterance)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
