//
//  TabsView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct TabsView: View {

    @EnvironmentObject var protectionVM: ProtectionVM
    
    @StateObject var appsSelectionVM = AppsSelectionVM()
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
           ProtectedAppsListView()
//                .environmentObject(protectionVM)
                .environmentObject(appsSelectionVM)
                .tabItem {
                    VStack {
                        Image(systemName: "square.fill.text.grid.1x2")
                        Text("Overview")
                    }
                }
                .tag(0) // Tag for the first tab
            
//            MonitoringView()
//                .environmentObject(appsSelectionVM)
//                .tabItem {
//                    VStack {
//                        Image(systemName: "person.fill")
//                        Text("Profile")
//                    }
//                }
//                .tag(1) // Tag for the second tab
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .environmentObject(ProtectionVM())
    }
}
