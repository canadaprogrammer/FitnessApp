//
//  TimerViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-12-02.
//

import UIKit

class TimerViewController: UIViewController {
    var isPlaying: Bool = false {
        didSet {
            playPauseButton.isSelected = isPlaying
        }
    }
    
    @IBOutlet var playPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
