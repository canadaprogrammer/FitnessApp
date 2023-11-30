//
//  ViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-11-28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var roundsCountLabel: UILabel!
    @IBOutlet var warmUpPicker: UIDatePicker!
    @IBOutlet var workPicker: UIDatePicker!
    @IBOutlet var restPicker: UIDatePicker!
    @IBOutlet var coolDownPicker: UIDatePicker!
    
    var roundsCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundsCountLabel.text = String(roundsCount)
    }
    
    @IBAction func roundsSliderChanged(_ sender: UISlider) {
        roundsCount = Int(sender.value)
        roundsCountLabel.text = String(roundsCount)
    }
    

}

