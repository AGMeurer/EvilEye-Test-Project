//
//  SetScheduleV.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import Foundation
import DeviceActivity
import SwiftUI
import ManagedSettings

class SetScheduleVM: ObservableObject {
    
    @Published var isLoadingAppGroup: Bool = false
    @Published var isAddingSchedule: Bool = false
    @Published var hasAddedSchedule: Bool = false
    @Published var loadedAppGroups: [AppConfig] = []
    
    @Published var activityName: String = ""
    @Published var appGroup: AppConfig?
    @Published var day: Date = Date()
    @Published var startTime: Date = Date()
    @Published var endTime:  Date = Date()
    @Published var schedule: DeviceActivitySchedule?
    
    @Published var showStartTime: Bool = false
    @Published var showEndTime: Bool = false
    @Published var showAppGroups: Bool = false
    
    func loadAppGroups() async {
        print("Loading App Group")
        
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                
                await MainActor.run(body: {
                    withAnimation {
                        isLoadingAppGroup = true
                    }
                })
                
                let decodedSearches = try JSONDecoder().decode([AppConfig].self, from: data)
                print("Decoded AppGroups Count: \(decodedSearches.count)")
                
                await MainActor.run(body: {
                    withAnimation {
                        isLoadingAppGroup = false
                        self.loadedAppGroups = decodedSearches
                    }
                })
                
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
    }
    
    func saveSchedule() async {
        Task {
            print("Saving Schedule")
            do {
                
                guard let appGroup = self.appGroup else { return }
                
                await MainActor.run(body: {
                    withAnimation {
                        isAddingSchedule = true
                    }
                })
                
                let schedule = ActivityEvent(activityName: activityName, appGroup: appGroup, day: day, startTime: startTime, endTime: endTime)
                
                let APP_GROUP_NAME = "monitor"
                let sharedDefaults = UserDefaults(suiteName: APP_GROUP_NAME)
                let encodedData = try JSONEncoder().encode(schedule)
               sharedDefaults?.set(encodedData, forKey: activityName)
                
                startMonitoring(deviceActivityName: activityName)
                
                await MainActor.run(body: {
                    withAnimation {
                        isAddingSchedule = false
                        self.hasAddedSchedule = true
                    }
                })
                
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }
    
    func startMonitoring(deviceActivityName: String) {
        let deviceActivityCenter = DeviceActivityCenter()
        
        let startTime = hourAndMinute(from: startTime)
        let endTime = hourAndMinute(from: endTime)
        
        let schedule: DeviceActivitySchedule = DeviceActivitySchedule(intervalStart: DateComponents(hour: Date().hour ,minute: Date().minute), intervalEnd: DateComponents(hour: Date().hour, minute: Date().minute + 15), repeats: true)
        
        let schedule1: DeviceActivitySchedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: Date().hour, minute: Date().minute),
            intervalEnd: DateComponents(hour: Date().hour, minute: Date().minute + 15),
            repeats: true)
        
        print("Start Monitoring \(deviceActivityName)")
        try? deviceActivityCenter.startMonitoring(DeviceActivityName(deviceActivityName), during: schedule)
        
//        if let appConfig = appGroup {
//            let applications = appConfig.selection.applicationTokens
//            let categories = appConfig.selection.categoryTokens
//            let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(appGroup.selectionName))
//
//            store.shield.applications = applications.isEmpty ? nil : applications
//            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//            store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//        }
    }
}
