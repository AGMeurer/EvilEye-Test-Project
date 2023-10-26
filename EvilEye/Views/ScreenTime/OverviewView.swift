//
//  OverviewView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

struct OverviewView: View {
    
    @Environment(\.openURL) var openURL
    
    @StateObject var scheduleVM = DeviceActivityScheduleVM()

    @State private var showAppsList: Bool = false
    @State private var activitySelection = FamilyActivitySelection()
    
    @State private var showAddAppGroup: Bool = false
    @State private var showSetSchedule: Bool = false
    
    @State private var openButton: Bool = false
    
    @State var openURLSheet: Bool = false
    
    var body: some View {
        NavigationSceleton(navigationBarTitle: "Overview", subTitle: "See what is going on", navbarDisplayMode: .large, contentWrapper: .noWrapper, navType: .navigationView) {
            ///- Note: Content
            VStack(spacing: 15) {
                SetupListView()
            }
        } bottomContent: {
            ///- Note: Bottom Button
        } navbarLargeContent: {
            
        } navbarLeading: {
            
        } navbarCenter: {
            Logo(size: 30)
        } navbarTrailing: {
            
        }
        .fullScreenCover(isPresented: $showAddAppGroup) {
            AppsConfigView(showAddAppConfig: $showAddAppGroup)
        }
    }
    
    private func SetupListView()-> some View {
        List {
            SetUpAppSelection()
        }
    }
    
    @ViewBuilder
    func SetUpAppSelection()-> some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.showAddAppGroup = true
            }, label: {
                HStack {
                    TextModifier(text: "Manage App Groups", fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
                    Spacer()
                    SFSymbol(iconName: "plus", size: .title3, weight: .bold, fgColor: .blue, renderingMode: .hierarchical)
                }
            })
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
