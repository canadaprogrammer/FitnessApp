//
//  TimerViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-12-02.
//

import UIKit

class TimerViewController: UIViewController {
    var timer = Timer()
    
    var isPlaying: Bool = false {
        didSet {
            playPauseButton.isSelected = isPlaying
        }
    }
    
    @IBOutlet var roundsLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var remainingTimeLabel: UILabel!
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var playPauseButton: UIButton!
    
    var timerMinutes: String = "00"
    var timerSeconds: String = "00"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundsLabel.text = "Round 1 / \(timer.rounds)"
        if timer.warmUp.minutes > 0 || timer.warmUp.seconds > 0 {
            statusLabel.text = "Warm Up"
            timerLabel.text = timer.printMinutesSeconds(minutes: timer.warmUp.minutes, seconds: timer.warmUp.seconds)
        } else if timer.work.minutes > 0 || timer.work.seconds > 0{
            statusLabel.text = "Work"
            timerLabel.text = timer.printMinutesSeconds(minutes: timer.work.minutes, seconds: timer.work.seconds)
        } else {
            statusLabel.text = "No Work"
            timerLabel.text = "00:00"
        }
        
        remainingTimeLabel.text = timer.printMinutesSeconds(minutes: Int(timer.remainingTime / 60), seconds: Int(timer.remainingTime % 60))
        totalTimeLabel.text = timer.printMinutesSeconds(minutes: Int(timer.CalculateSeconds()["totalSeconds"]! / 60), seconds: Int(timer.CalculateSeconds()["totalSeconds"]! % 60))
    }
    
    @IBAction func playPuaseButtonTapped(_ sender: UIButton) {
        isPlaying.toggle()
        print(isPlaying)
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
