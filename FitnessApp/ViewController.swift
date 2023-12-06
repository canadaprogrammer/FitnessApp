//
//  ViewController.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-11-28.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var countDown = CountDown()
    
    @IBOutlet var roundsCountLabel: UILabel!
    @IBOutlet var roundsSlider: UISlider!
    @IBOutlet var warmUpPicker: UIPickerView!
    @IBOutlet var workPicker: UIPickerView!
    @IBOutlet var restPicker: UIPickerView!
    @IBOutlet var coolDownPicker: UIPickerView!
    @IBOutlet var totalLabel: UILabel!
    
    var pickerData:[[Int]] = [[Int]]()
    let range:[Int] = Array(0..<60)
    
    var labelTexts = ["Min", "Sec"]
    
    var warmUpSeconds: Int = 0
    var workSeconds: Int = 0
    var restSeconds: Int = 0
    var coolDownSeconds: Int = 0
    var totalSeconds:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerData = [range, range]
        
        initializePickers()
        
        updateTotal()
    }
    
    func initializePickers() {
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
        
        roundsCountLabel.text = String(countDown.rounds)
        roundsSlider.value = Float(countDown.rounds)
        
        warmUpPicker!.selectRow(countDown.warmUp.minutes, inComponent: 0, animated: true)
        warmUpPicker!.selectRow(countDown.warmUp.seconds, inComponent: 1, animated: true)
        
        workPicker!.selectRow(countDown.work.minutes, inComponent: 0, animated: true)
        workPicker!.selectRow(countDown.work.seconds, inComponent: 1, animated: true)
        
        restPicker!.selectRow(countDown.rest.minutes, inComponent: 0, animated: true)
        restPicker!.selectRow(countDown.rest.seconds, inComponent: 1, animated: true)
        
        coolDownPicker!.selectRow(countDown.coolDown.minutes, inComponent: 0, animated: true)
        coolDownPicker!.selectRow(countDown.coolDown.seconds, inComponent: 1, animated: true)
    }
    
    
    func updateTotal() {
        countDown.CalculateSeconds()
        totalLabel.text = countDown.printMinutesSeconds(minutes: Int(countDown.totalSeconds / 60), seconds: Int(countDown.totalSeconds % 60))
    }
    
    @IBAction func roundsSliderChanged(_ sender: UISlider) {
        countDown.rounds = Int(sender.value)
        roundsCountLabel.text = String(countDown.rounds)
        
        updateTotal()
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
                countDown.warmUp.minutes = pickerData[component][row]
            } else {
                countDown.warmUp.seconds = pickerData[component][row]
            }
            break
        case workPicker:
            if component == 0 {
                countDown.work.minutes = pickerData[component][row]
            } else {
                countDown.work.seconds = pickerData[component][row]
            }
            break
        case restPicker:
            if component == 0 {
                countDown.rest.minutes = pickerData[component][row]
            } else {
                countDown.rest.seconds = pickerData[component][row]
            }
            break
        case coolDownPicker:
            if component == 0 {
                countDown.coolDown.minutes = pickerData[component][row]
            } else {
                countDown.coolDown.seconds = pickerData[component][row]
            }
        default:
            break
        }
        
        updateTotal()
    }
    @IBSegueAction func settings(_ coder: NSCoder) -> CountDownViewController? {
        let countDownViewcontroller = CountDownViewController(coder: coder)
        countDownViewcontroller?.countDown = countDown
        return countDownViewcontroller
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
