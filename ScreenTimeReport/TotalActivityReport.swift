//
//  TotalActivityReport.swift
//  ScreenTimeReport
//
//  Created by Alexander Meurer on 8/18/23.
//

import DeviceActivity
import SwiftUI

// MARK: - Device Activity Report
extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
   static let totalActivity = Self("Total Activity")
}

// MARK: - Device Activity Report
struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.

    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (ActivityReport) -> TotalActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        var totalScreenTime = ""
        var list: [AppDeviceActivity] = []
        
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        for await eachData in data {
            totalScreenTime += eachData.user.appleID!.debugDescription
            totalScreenTime += eachData.lastUpdatedDate.description
            for await activitySegment in eachData.activitySegments {
                totalScreenTime += activitySegment.totalActivityDuration.formatted()
                for await category in activitySegment.categories {
                    for await application in category.applications {
                        let appName = (application.application.localizedDisplayName ?? "nil")
                        let bundle = (application.application.bundleIdentifier ?? "nil")
                        let duration = application.totalActivityDuration
                        let numberOfPickups = application.numberOfPickups
                        let g = application.application.token
                        
                        let appActivity = AppDeviceActivity(
                            id: bundle,
                            token: g,
                            displayName: appName,
                            duration: duration,
                            numberOfPickups: numberOfPickups)
                       
                        list.append(appActivity)
                    }
                }
                
            }
        }
        
        return ActivityReport(totalDuration: totalActivityDuration, apps: list)
    }
    

}
