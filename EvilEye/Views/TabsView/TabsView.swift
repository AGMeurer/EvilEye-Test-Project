//
//  TabsView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct TabsView: View {

    @EnvironmentObject var protectionVM: ProtectionVM
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
           ProtectedAppsListView()
                .tabItem {
                    VStack {
                        Image(systemName: "apps.iphone")
                        Text("Shortcut related")
                    }
                }
                .tag(0) // Tag for the first tab
            
            OverviewView()
                .tabItem {
                    VStack {
                        Image(systemName: "shield.lefthalf.filled")
                        Text("ScreenTime related")
                    }
                }
                .tag(1) // Tag for the second tab
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .environmentObject(ProtectionVM())
    }
}
