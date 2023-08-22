//
//  DeviceActivityScheduleVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

// EXTENSION: Create a DeviceActivityMonitor

import Foundation
import DeviceActivity
import FamilyControls

// APP: Monitor a DeviceActivitySchedule
extension DeviceActivityName {
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    // Set the name of the event to "encouraged"
    static let discouraged = Self("discouraged")
}

class DeviceActivityScheduleVM: ObservableObject {
    
    func setSchedule(eventName: DeviceActivityEvent.Name, applications: FamilyActivitySelection) {
        Task {

            print("Setting schedule...")
            print("Hour is: ", Calendar.current.dateComponents([.hour, .minute], from: Date()).hour!)
            
            //- 1. Creating a Schedule
            let schedule = addSchedule(date: Date())
            
            //- 2 Creating a Event
            let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [ .discouraged: DeviceActivityEvent(applications: applications.applicationTokens,
                threshold: DateComponents(minute: 1)
                                                                               )
            ]
            
            //- 3 Create a Device Activity center
            let center = DeviceActivityCenter()
            
            do {
                print("Try to start monitoring...")
                //- 4 Call startMonitoring with the activity name, schedule, and events
                try center.startMonitoring(.daily, during: schedule, events: events)
                
            } catch {
                print("Error monitoring schedule: ", error)
            }
        }
    }
    
    func addSchedule(date: Date) -> DeviceActivitySchedule  {
        // The Device Activity schedule represents the time bounds in which my extension will monitor for activity
        let schedule = DeviceActivitySchedule(
            // I've set my schedule to start and end at midnight
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            // I've also set the schedule to repeat
            repeats: true
        )
        
        return schedule
    }
   
}
