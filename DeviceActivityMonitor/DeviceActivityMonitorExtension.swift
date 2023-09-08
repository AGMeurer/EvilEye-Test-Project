//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityMonitor
//
//  Created by Alexander Meurer on 8/17/23.
//

import Foundation
import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    
    let store = ManagedSettingsStore()
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        // Handle the start of the interval.
        store.clearAllSettings()
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        store.clearAllSettings()
        
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
        let selection = FamilyActivitySelection.fromKey(activity.rawValue)
        let store = ManagedSettingsStore(named: .init(activity.rawValue))
        store.shield.applications = selection.applicationTokens
        store.shield.webDomains = selection.webDomainTokens
    }
    
    //    override func intervalWillStartWarning(for activity: DeviceActivityName) {
    //        super.intervalWillStartWarning(for: activity)
    //
    //        // Handle the warning before the interval starts.
    //    }
    //
    //    override func intervalWillEndWarning(for activity: DeviceActivityName) {
    //        super.intervalWillEndWarning(for: activity)
    //
    //        // Handle the warning before the interval ends.
    //    }
    //
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}

extension FamilyActivitySelection {
    static func fromKey(_ key: String) -> FamilyActivitySelection {
        if let data = UserDefaults.group()?.data(forKey: key),
           let selection = try? JSONDecoder().decode(
            FamilyActivitySelection.self,
            from: data
           )  {
            return selection
        } else {
            return FamilyActivitySelection(includeEntireCategory: false)
        }
    }
}

extension UserDefaults {
    static func group() -> UserDefaults? {
        return UserDefaults(
            suiteName: "group.com.EvilEye.EvilEye-IOS.shared"
        )
    }
}




