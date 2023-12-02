//
//  ViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-11-28.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var roundsCountLabel: UILabel!
    @IBOutlet var warmUpPicker: UIPickerView!
    @IBOutlet var workPicker: UIPickerView!
    @IBOutlet var restPicker: UIPickerView!
    @IBOutlet var coolDownPicker: UIPickerView!
    @IBOutlet var totalLabel: UILabel!
    
    var pickerData:[[Int]] = [[Int]]()
    let range:[Int] = Array(0..<60)
    
    var roundsCount: Int = 0
    
    var labelTexts = ["Min", "Sec"]
    
    var selectedWarmUp:[String:Int] = ["Minutes":0, "Seconds":0]
    var selectedWork:[String:Int] = ["Minutes":0, "Seconds":0]
    var selectedRest:[String:Int] = ["Minutes":0, "Seconds":0]
    var selectedCoolDown:[String:Int] = ["Minutes":0, "Seconds":0]
    
    var warmUpSeconds: Int = 0
    var workSeconds: Int = 0
    var restSeconds: Int = 0
    var coolDownSeconds: Int = 0
    var totalSeconds:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundsCountLabel.text = String(roundsCount)
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
        roundsCount = Int(sender.value)
        roundsCountLabel.text = String(roundsCount)
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
                selectedWarmUp["Minutes"] = pickerData[component][row]
            } else {
                selectedWarmUp["Seconds"] = pickerData[component][row]
            }
            break
        case workPicker:
            if component == 0 {
                selectedWork["Minutes"] = pickerData[component][row]
            } else {
                selectedWork["Seconds"] = pickerData[component][row]
            }
            break
        case restPicker:
            if component == 0 {
                selectedRest["Minutes"] = pickerData[component][row]
            } else {
                selectedRest["Seconds"] = pickerData[component][row]
            }
            break
        case coolDownPicker:
            if component == 0 {
                selectedCoolDown["Minutes"] = pickerData[component][row]
            } else {
                selectedCoolDown["Seconds"] = pickerData[component][row]
            }
        default:
            break
        }
        
        
        warmUpSeconds = selectedWarmUp["Minutes"]! * 60 + selectedWarmUp["Seconds"]!
        workSeconds = selectedWork["Minutes"]! * 60 + selectedWork["Seconds"]!
        restSeconds = selectedRest["Minutes"]! * 60 + selectedRest["Seconds"]!
        coolDownSeconds = selectedCoolDown["Minutes"]! * 60 + selectedCoolDown["Seconds"]!
        totalSeconds = warmUpSeconds + coolDownSeconds + (workSeconds + restSeconds) * roundsCount
        let totalMinutes = String(format: "%02d", Int(totalSeconds / 60))
        let totalSeconds = String(format: "%02d", Int(totalSeconds % 60))
        
        totalLabel.text = "\(totalMinutes):\(totalSeconds)"
        print(totalSeconds)
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
