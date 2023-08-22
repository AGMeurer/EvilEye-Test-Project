//
//  ScreenTimeActivityReport.swift
//  ScreenTimeReport
//
//  Created by Alexander Meurer on 8/18/23.
//

import Foundation
import FamilyControls
import ManagedSettings

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var token: ApplicationToken?
    var displayName: String
    var duration: TimeInterval
    var numberOfPickups: Int
}

extension TimeInterval {
    /// TimeInterval 타입 값을 00:00 형식의 String으로 변환해주는 메서드
    func toString() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d", hours,minutes)
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
