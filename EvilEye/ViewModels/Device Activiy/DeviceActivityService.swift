//
//  DeviceActivityService.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/22/23.
//


import SwiftUI
import FamilyControls
import DeviceActivity
import ScreenTime
import ManagedSettings

class DeviceActivityService {
    static let shared = DeviceActivityService()
    private let center = DeviceActivityCenter()
    
    func startMonitoring(appConfig: AppConfig) {
        do {
            print("MONITORING: 1. Started Monitoring")
            
//            guard let id = appConfig.id else { return }
            
            //- 1. Creating a Schedule
            let schedule = addSchedule(date: Date())
            print("MONITORING: 2. Added Schedule")
            
            print("SELECTION COUNT: \(appConfig.familyActivitySelection.applicationTokens.count)")
            
            //- 2 Creating a Event
            let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [ DeviceActivityEvent.Name.fromId(String(appConfig.id)): DeviceActivityEvent(applications: appConfig.familyActivitySelection.applicationTokens,
                threshold: DateComponents(second: 10))
            ]
            print("MONITORING: 3. Created Event")
            
            let activity = DeviceActivityName.fromId(String(appConfig.id))
            print("MONITORING: 4. Created Activity named: \(activity.rawValue)")
            
            try center.startMonitoring(activity, during: schedule, events: events)
            
            print("MONITORING: 5. Started Monitoring")
        } catch {
            
            print("MONITORING: 6. ERROR")
            print(error)
        }
    }
    
    func stopMonitoring(appConfig: AppConfig) {
        
        print("STOP MO")
//        guard let id = appConfig.id else { return }
        
        let activity = DeviceActivityName.fromId(String(appConfig.id))
        let store = ManagedSettingsStore(named: .init(activity.rawValue))
        store.clearAllSettings()
        
        let e = center.events(for: activity)
        let event = e[DeviceActivityEvent.Name.fromId(String(appConfig.id))]
        let b = event?.threshold
    
        
        print("Activities it monitors: \(center.activities)")
        
        center.stopMonitoring([.fromId(String(appConfig.id))])
        // Handle the event reaching its threshold.
    }
    
    func addSchedule(date: Date) -> DeviceActivitySchedule  {
        // The Device Activity schedule represents the time bounds in which my extension will monitor for activity
        let schedule = DeviceActivitySchedule(
            // I've set my schedule to start and end at midnight
            intervalStart: DateComponents(hour: Date().hour, minute: Date().minute),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            // I've also set the schedule to repeat
            repeats: false
        )
        
        return schedule
    }
    
    func getThreshold(_ appConfig: AppConfig) -> DateComponents? {
        
//        guard let id = appConfig.id else { return nil }
        
        let activity = DeviceActivityName.fromId(String(appConfig.id))
        
        let events = center.events(for: activity)
        let event = events[DeviceActivityEvent.Name.fromId(String(appConfig.id))]
        return event?.threshold
    }
}

@available(iOS 16.0, *)
extension DeviceActivityName {
    static func fromId(_ id: String) -> DeviceActivityName {
        return DeviceActivityName("device_activity_\(id)")
    }
}

extension DeviceActivityEvent.Name {
    static func fromId(_ id: String) -> DeviceActivityEvent.Name {
        return DeviceActivityEvent.Name("device_activity_\(id)")
    }
}
