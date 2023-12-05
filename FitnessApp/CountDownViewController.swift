//
//  CountDownViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-12-02.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundsLabel.text = "Round 1 / \(countDown.rounds)"
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
        totalTimeLabel.text = countDown.printMinutesSeconds(minutes: Int(countDown.CalculateSeconds()["totalSeconds"]! / 60), seconds: Int(countDown.CalculateSeconds()["totalSeconds"]! % 60))
    }
    
    @IBAction func playPuaseButtonTapped(_ sender: UIButton) {
        isPlaying.toggle()
        if isPlaying {
            countDown.remainingTime -= 1
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
