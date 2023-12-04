//
//  ViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-11-28.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var timer = Timer()
    
    @IBOutlet var roundsCountLabel: UILabel!
    @IBOutlet var warmUpPicker: UIPickerView!
    @IBOutlet var workPicker: UIPickerView!
    @IBOutlet var restPicker: UIPickerView!
    @IBOutlet var coolDownPicker: UIPickerView!
    @IBOutlet var totalLabel: UILabel!
    
    var pickerData:[[Int]] = [[Int]]()
    let range:[Int] = Array(0..<60)
    
//    var roundsCount: Int = 0
    
    var labelTexts = ["Min", "Sec"]
    
//    var selectedWarmUp = timeInput(minutes: 0, seconds: 0)
//    var selectedWork = timeInput(minutes: 0, seconds: 0)
//    var selectedRest = timeInput(minutes: 0, seconds: 0)
//    var selectedCoolDown = timeInput(minutes: 0, seconds: 0)
    
    var warmUpSeconds: Int = 0
    var workSeconds: Int = 0
    var restSeconds: Int = 0
    var coolDownSeconds: Int = 0
    var totalSeconds:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundsCountLabel.text = String(timer.rounds)
        pickerData = [range, range]
        
        self.warmUpPicker.delegate = self
        self.warmUpPicker.dataSource = self
        warmUpPicker.setPickerLabels(labelSize: 20.0, labelTexts: labelTexts)
        
        self.workPicker.delegate = self
        self.workPicker.dataSource = self
        workPicker.setPickerLabels(labelSize: 20.0, labelTexts: labelTexts)
        
        self.restPicker.delegate = self
        self.restPicker.dataSource = self
        restPicker.setPickerLabels(labelSize: 20.0, labelTexts: labelTexts)
        
        self.coolDownPicker.delegate = self
        self.coolDownPicker.dataSource = self
        coolDownPicker.setPickerLabels(labelSize: 20.0, labelTexts: labelTexts)
        
    }
    
    @IBAction func roundsSliderChanged(_ sender: UISlider) {
        timer.rounds = Int(sender.value)
        roundsCountLabel.text = String(timer.rounds)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[component][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case warmUpPicker:
            if component == 0 {
                timer.warmUp.minutes = pickerData[component][row]
            } else {
                timer.warmUp.seconds = pickerData[component][row]
            }
            break
        case workPicker:
            if component == 0 {
                timer.work.minutes = pickerData[component][row]
            } else {
                timer.work.seconds = pickerData[component][row]
            }
            break
        case restPicker:
            if component == 0 {
                timer.rest.minutes = pickerData[component][row]
            } else {
                timer.rest.seconds = pickerData[component][row]
            }
            break
        case coolDownPicker:
            if component == 0 {
                timer.coolDown.minutes = pickerData[component][row]
            } else {
                timer.coolDown.seconds = pickerData[component][row]
            }
        default:
            break
        }
        
        
//        warmUpSeconds = timer.warmUp.minutes * 60 + timer.warmUp.seconds
//        workSeconds = (timer.work.minutes * 60 + timer.work.seconds) * timer.rounds
//        let restSecondsUnit = timer.rest.minutes * 60 + timer.rest.seconds
//        restSeconds = restSecondsUnit * timer.rounds
//        
//        if restSeconds > 0 {
//            restSeconds -= restSecondsUnit
//        }
//        
//        coolDownSeconds = timer.coolDown.minutes * 60 + timer.coolDown.seconds
//        totalSeconds = warmUpSeconds + coolDownSeconds + workSeconds + restSeconds
        
        totalLabel.text = timer.printMinutesSeconds(minutes: Int(timer.CalculateSeconds()["totalSeconds"]! / 60), seconds: Int(timer.CalculateSeconds()["totalSeconds"]! % 60))
    }
    @IBSegueAction func settings(_ coder: NSCoder) -> TimerViewController? {
        let timerViewcontroller = TimerViewController(coder: coder)
        timerViewcontroller?.timer = timer
        return timerViewcontroller
    }
}

extension UIPickerView {
    func setPickerLabels(labelSize: Double, labelTexts: [String]) {
        let font = UIFont.systemFont(ofSize: labelSize)
        let fontSize: CGFloat = font.pointSize
        let labelWidth: CGFloat = self.frame.width / CGFloat(self.numberOfComponents)
        let y = (self.frame.size.height / 2) - (fontSize / 2)
        
        for index in 0..<labelTexts.count {
            let label = UILabel(frame: CGRect(x: (self.frame.origin.x + labelWidth) * CGFloat(index) * 0.43, y: CGFloat(y), width: labelWidth, height: CGFloat(fontSize)))
            label.text = labelTexts[index]
            label.textAlignment = .right
            self.addSubview(label)
        }
    }
}
