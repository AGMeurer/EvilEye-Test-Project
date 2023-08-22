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
    let sharedDefaults = UserDefaults(suiteName: "monitor")
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        // Handle the start of the interval.
        store.clearAllSettings()

    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)

        // Handle the end of the interval.
        if let savedData = sharedDefaults?.object(forKey: activity.rawValue) as? Data {
            let decoder = JSONDecoder()
            do {
                
                let object = try decoder.decode(ActivityEvent.self, from: savedData)
                print("object")
                
                let applications = object.appGroup.selection.applicationTokens
                let categories = object.appGroup.selection.categoryTokens
                let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(object.appGroup.selectionName))
                
                store.shield.applications = applications.isEmpty ? nil : applications
                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
                store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
                
            } catch {
                print("Failed to decode object:", error)
            }
        }
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}

extension ManagedSettingsStore.Name {
    
    static func dynamicName(for key: String) -> ManagedSettingsStore.Name {
        if let storedValue = UserDefaults.standard.string(forKey: key) {
            return Self(storedValue)
        } else {
            fatalError("Name for key \(key) not found in UserDefaults!")
        }
    }
}

struct ActivityEvent: Codable {
    var activityName: String
    var appGroup: AppGroup
    var day: Date
    var startTime: Date
    var endTime: Date
}

///- Note: Used to Shield Applications or Categories in a specified ManagedSettingsStore
struct AppGroup: Codable {
//    var id: String
    //- Used for display name of selection (example: Productivity), but also ManagedSettingsStore.Name
    var selectionName: String
    var icon: String
    var selection: FamilyActivitySelection
    
}
