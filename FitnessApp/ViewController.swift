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
    
    var pickerData:[[Int]] = [[Int]]()
    let range:[Int] = Array(0..<60)
    
    var roundsCount: Int = 0
    
    var labelTexts = ["Min", "Sec"]
    
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
        print(pickerData[component][row])
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
