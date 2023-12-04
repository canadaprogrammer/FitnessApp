//
//  Timer.swift
//  FitnessApp
//
//  Created by Jungjin Park on 2023-12-03.
//
struct Timer {
    var rounds: Int
    var warmUp: timeInput
    var work: timeInput
    var rest: timeInput
    var coolDown: timeInput
    var remainingTime: Int
    
    init(rounds: Int = 0, warmUp: timeInput = timeInput(minutes: 0, seconds: 0), work: timeInput = timeInput(minutes: 0, seconds: 0), rest: timeInput = timeInput(minutes: 0, seconds: 0), coolDown: timeInput = timeInput(minutes: 0, seconds: 0), remainingTime: Int = 0) {
        self.rounds = rounds
        self.warmUp = warmUp
        self.work = work
        self.rest = rest
        self.coolDown = coolDown
        self.remainingTime = remainingTime
    }
    
    mutating func CalculateSeconds() -> [String: Int] {
        let warmUpSeconds = self.warmUp.minutes * 60 + self.warmUp.seconds
        let workSeconds = (self.work.minutes * 60 + self.work.seconds) * self.rounds
        let restSecondsUnit = self.rest.minutes * 60 + self.rest.seconds
        var restSeconds = restSecondsUnit * self.rounds
        
        if restSeconds > 0 {
            restSeconds -= restSecondsUnit
        }
        
        let coolDownSeconds = self.coolDown.minutes * 60 + self.coolDown.seconds
        let totalSeconds = warmUpSeconds + coolDownSeconds + workSeconds + restSeconds
        self.remainingTime = totalSeconds
        
        return ["warmUpSeconds": warmUpSeconds, "workSeconds": workSeconds, "restSeconds": restSeconds, "coolDownSeconds": coolDownSeconds, "totalSeconds": totalSeconds]
    }
    
    
    func printMinutesSeconds(minutes: Int, seconds: Int) -> String {
        let minutesTwoDigits = String(format: "%02d", minutes)
        let secondsTwoDigits = String(format: "%02d", seconds)
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
