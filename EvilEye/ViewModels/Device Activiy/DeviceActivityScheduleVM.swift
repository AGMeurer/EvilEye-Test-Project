//
//  DeviceActivityScheduleVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

// EXTENSION: Create a DeviceActivityMonitor

import Foundation
import DeviceActivity

// APP: Monitor a DeviceActivitySchedule
extension DeviceActivityName {
    static let daily = Self("daily")
}

class DeviceActivityScheduleVM: ObservableObject {
    
    ///- Note: Represents the time bounds in which the extension will monitor for activity
    let schedule = DeviceActivitySchedule(
        intervalStart: DateComponents(hour: 0, minute: 0),
        intervalEnd: DateComponents(hour: 22, minute: 0),
        repeats: true
    )
    
    let center = DeviceActivityCenter()
    
    func startMonitoring() {
        Task {
            do {
                try center.startMonitoring(.daily, during: schedule)
            } catch {
                
            }
        }
    }
   
}
