//
//  DatesHelper.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import Foundation

extension Date {
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
}

func formatTimeInterval(_ interval: TimeInterval) -> String {
    let hours = Int(interval) / 3600
    let minutes = (Int(interval) % 3600) / 60
    let seconds = Int(interval) % 60
    
    if hours > 0 {
        return "\(hours) Hours \(minutes) Minutes"
    } else if minutes > 0 {
        return "\(minutes) Minutes"
    } else {
        return "\(seconds) Seconds"
    }
}

func hourAndMinute(from date: Date) -> (hour: Int, minute: Int) {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
    
    return (hour, minute)
}

//let timeInterval: TimeInterval = 720 // 12 minutes in seconds
//let formattedTime = formatTimeInterval(timeInterval)
//print(formattedTime)  // Output: 12 Minutes
