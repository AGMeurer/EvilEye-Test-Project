//
//  TotalActivityView.swift
//  ScreenTimeReport
//
//  Created by Alexander Meurer on 8/18/23.
//

import SwiftUI

struct TotalActivityView: View {
    
    var activityReport: ActivityReport
    
    var body: some View {
        VStack {
            Spacer(minLength: 50)
            Text("Total Screen Time")
            Spacer(minLength: 10)
            Text(String(formatTimeInterval(activityReport.totalDuration)))
        
            List {
                HStack {
                    Text("App")
                    Spacer()
                    Spacer()
                    Text("Pickups")
                    Spacer()
                    Text("Duration")
                }
                
                ForEach(activityReport.apps) { eachApp in
                    ListRow(eachApp: eachApp)
                }
            }
        }
    }
}

struct ListRow: View {
    var eachApp: AppDeviceActivity
    
    var body: some View {
        HStack {
            if let token = eachApp.token {
                Label(token)
            } else {
                Text(eachApp.displayName)
            }
            Spacer()
            Text("\(eachApp.numberOfPickups)")
            Spacer()
            Text(String(formatTimeInterval(eachApp.duration)))
        }
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
//struct TotalActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        TotalActivityView(
//            activityReport: ActivityReport(
//                totalDuration: .zero,
//                apps: [
//                    AppDeviceActivity(id: "id1", displayName: "app1", duration: .zero, numberOfPickups: 3),
//                    AppDeviceActivity(id: "id2", displayName: "app2", duration: .zero, numberOfPickups: 5)
//                ]
//            )
//        )
//    }
//}
