//
//  CountDown.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-12-03.
//
struct CountDown {
    var rounds: Int
    var warmUp: timeInput
    var work: timeInput
    var rest: timeInput
    var coolDown: timeInput
    var warmUpSeconds: Int
    var workSecondsUnit: Int
    var workSeconds: Int
    var restSecondsUnit: Int
    var restSeconds: Int
    var coolDownSeconds: Int
    var totalSeconds: Int
    var remainingTime: Int
    
    init(rounds: Int = 2, warmUp: timeInput = timeInput(minutes: 0, seconds: 5), work: timeInput = timeInput(minutes: 0, seconds: 10), rest: timeInput = timeInput(minutes: 0, seconds: 5), coolDown: timeInput = timeInput(minutes: 0, seconds: 10), remainingTime: Int = 0) {
        self.rounds = rounds
        self.warmUp = warmUp
        self.work = work
        self.rest = rest
        self.coolDown = coolDown
        self.remainingTime = remainingTime
        
        self.warmUpSeconds = warmUp.minutes * 60 + warmUp.seconds
        
        self.workSecondsUnit = work.minutes * 60 + work.seconds
        self.workSeconds = (work.minutes * 60 + work.seconds) * rounds
        
        self.restSecondsUnit = rest.minutes * 60 + rest.seconds
        self.restSeconds = self.restSecondsUnit * rounds
        
        if self.restSeconds > 0 {
            self.restSeconds -= self.restSecondsUnit
        }
        
        self.coolDownSeconds = coolDown.minutes * 60 + coolDown.seconds
        self.totalSeconds = self.warmUpSeconds + self.coolDownSeconds + self.workSeconds + self.restSeconds
        self.remainingTime = self.totalSeconds
    }
    
    mutating func CalculateSeconds() {
        self.warmUpSeconds = self.warmUp.minutes * 60 + self.warmUp.seconds
        self.workSecondsUnit = work.minutes * 60 + work.seconds
        self.workSeconds = self.workSecondsUnit * self.rounds
        self.restSecondsUnit = rest.minutes * 60 + rest.seconds
        self.restSeconds = self.restSecondsUnit * self.rounds
        
        if self.restSeconds > 0 {
            self.restSeconds -= self.restSecondsUnit
        }
        
        self.coolDownSeconds = self.coolDown.minutes * 60 + self.coolDown.seconds
        self.totalSeconds = self.warmUpSeconds + self.coolDownSeconds + self.workSeconds + self.restSeconds
        self.remainingTime = self.totalSeconds
    }
    
    
    func printMinutesSeconds(minutes: Int, seconds: Int) -> String {
        let minutesTwoDigits = String(format: "%02d", minutes)
        let secondsTwoDigits = String(format: "%02d", seconds)
        return "\(minutesTwoDigits):\(secondsTwoDigits)"
    }

    func printMinutesSeconds(seconds: Int) -> String {
        let minutesTwoDigits = String(format: "%02d", Int(seconds / 60))
        let secondsTwoDigits = String(format: "%02d", Int(seconds % 60))
        return "\(minutesTwoDigits):\(secondsTwoDigits)"
    }
}

class timeInput {
    var minutes: Int
    var seconds: Int
    
    init(minutes: Int, seconds: Int) {
        self.minutes = minutes
        self.seconds = seconds
    }
}
