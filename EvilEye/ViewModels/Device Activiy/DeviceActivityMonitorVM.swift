//
//  MonitorVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import SwiftUI
import DeviceActivity
import ManagedSettings

// EXTENSION: Create a DeviceActivityMonitor
class DeviceActivityMonitorVM: DeviceActivityMonitor {

    let store = ManagedSettingsStore()

    ///- Indicates that the device activity interval started.
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)

        let model = AppsSelectionVM()
        let applications = model.selection.applicationTokens

        store.shield.applications = applications
    }

    ///- An activity ends when someone first uses the device outside the activity’s scheduled time interval or when your app stops monitoring an activity with an ongoing interval. In other words, the system only invokes this method when the device is in use.
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)

        store.shield.applications = nil
    }
}
