//
//  CountDownViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-12-02.
//

import UIKit
import AVKit

class CountDownViewController: UIViewController {
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
        
        roundsLabel.text = "Round \(currentRound) / \(totalRounds)"
        if countDown.warmUp.minutes > 0 || countDown.warmUp.seconds > 0 {
            statusLabel.text = "Warm Up"
            countDownLabel.text = countDown.printMinutesSeconds(minutes: countDown.warmUp.minutes, seconds: countDown.warmUp.seconds)
        } else if countDown.work.minutes > 0 || countDown.work.seconds > 0{
            statusLabel.text = "Work"
            countDownLabel.text = countDown.printMinutesSeconds(minutes: countDown.work.minutes, seconds: countDown.work.seconds)
        } else {
            statusLabel.text = "No Work"
            countDownLabel.text = "00:00"
        }
        
        remainingTimeLabel.text = countDown.printMinutesSeconds(minutes: Int(countDown.remainingTime / 60), seconds: Int(countDown.remainingTime % 60))
        totalTimeLabel.text = countDown.printMinutesSeconds(minutes: Int(countDown.totalSeconds / 60), seconds: Int(countDown.totalSeconds % 60))
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
    
    func countDownTimer() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countDown.warmUpSeconds > 0 {
                self.countDown.warmUpSeconds -= 1
                self.countDownLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.warmUpSeconds)
                self.statusLabel.text = "Warm Up"
                if self.countDown.warmUpSeconds == 0 {
                    AudioServicesPlaySystemSound(SystemSoundID(1008))
                }
            } else if self.countDown.workSecondsUnit > 0 {
                self.countDown.workSecondsUnit -= 1
                self.countDownLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.workSecondsUnit)
                self.statusLabel.text = "Work"
                if self.countDown.workSecondsUnit == 0 {
                    AudioServicesPlaySystemSound(SystemSoundID(1013))
                }
            } else if self.countDown.restSecondsUnit > 0 {
                self.countDown.restSecondsUnit -= 1
                self.countDownLabel.text = self.countDown.printMinutesSeconds(seconds: self.countDown.restSecondsUnit)
                self.statusLabel.text = "Rest"
                // next round
                if self.countDown.restSecondsUnit == 0 {
                    AudioServicesPlaySystemSound(SystemSoundID(1008))
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
                    AudioServicesPlaySystemSound(SystemSoundID(1017))
                }
            } else {
                timer.invalidate()
                self.statusLabel.text = "Finish"
            }
        }
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
