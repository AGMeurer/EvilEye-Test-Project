//
//  ScreenTimeReport.swift
//  ScreenTimeReport
//
//  Created by Alexander Meurer on 8/18/23.
//

import DeviceActivity
import SwiftUI


@main
struct ScreenTimeReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(activityReport: totalActivity)
        }
        // Add more reports here...
    }
}

//@main
//struct ScreenTimeReport: DeviceActivityReportExtension {
//    var body: some DeviceActivityReportScene {
//        // Create a report for each DeviceActivityReport.Context that your app supports.
//        TotalActivityReport { totalActivity in
//            TotalActivityView(totalActivity: totalActivity)
//        }
//        // Add more reports here...
//    }
//}
