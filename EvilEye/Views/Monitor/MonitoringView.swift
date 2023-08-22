//
//  MonitoringView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
   static let totalActivity = Self("Total Activity")
}

struct MonitoringView: View {
    @EnvironmentObject var vm: AppsSelectionVM
    
    let context: DeviceActivityReport.Context = .totalActivity
    @State private var filter = DeviceActivityFilter(segment: .daily(during: Calendar.current.dateInterval(of: .day, for: .now)!))
    
    var body: some View {
        Text("Device Activity Report")
//        DeviceActivityReport(context, filter: filter)
//            .onAppear {
//                filter = DeviceActivityFilter(
//                    segment: .daily(
//                        during: Calendar.current.dateInterval(
//                            of: .day, for: .now
//                        )!
//                    ),
//                    users: .all,
//                    devices: .init([.iPhone]),
//                    applications: vm.selection.applicationTokens,
//                    categories: vm.selection.categoryTokens
//                )
//            }
    }
}

struct MonitoringView_Previews: PreviewProvider {
    static var previews: some View {
        MonitoringView()
    }
}
