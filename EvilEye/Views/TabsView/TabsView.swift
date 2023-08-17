//
//  TabsView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct TabsView: View {
    
    @StateObject var navVM = NavigationVM()
    
    var body: some View {
        TabView(selection: $navVM.selectedTab) {
            
            OverviewView()
                .environmentObject(navVM)
                .tabItem {
                    VStack {
                        Image(systemName: "square.fill.text.grid.1x2")
                        Text("Overview")
                    }
                }
                .tag(0) // Tag for the first tab
            
            ProfileView()
                .environmentObject(navVM)
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
