//
//  TabsView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct TabsView: View {
    
    @StateObject var navVM = NavigateVM()
    @StateObject var appsSelectionVM = AppsSelectionVM()
    
    var body: some View {
        TabView(selection: $navVM.selectedTab) {
            
            OverviewView()
                .environmentObject(appsSelectionVM)
                .environmentObject(navVM)
                .tabItem {
                    VStack {
                        Image(systemName: "square.fill.text.grid.1x2")
                        Text("Overview")
                    }
                }
                .tag(0) // Tag for the first tab
            
            MonitoringView()
                .environmentObject(navVM)
                .environmentObject(appsSelectionVM)
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
                .tag(1) // Tag for the second tab
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
