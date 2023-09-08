//
//  ContentView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI
import FamilyControls
import AppIntents

struct ContentView: View {
    
    @EnvironmentObject var familyControlsVM: FamilyControlsVM
    
    var body: some View {
        Group {
            if familyControlsVM.authorizationStatus == .approved {
                TabsView()
                    .onAppear( perform: {
                        familyControlsVM.requestNotificationPermission()
                    })
                
            } else {
                NotApprovedView()
                
            }
        }
        .environmentObject(familyControlsVM)
        
    }
}

