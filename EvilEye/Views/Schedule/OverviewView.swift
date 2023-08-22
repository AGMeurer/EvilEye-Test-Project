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
    
    @EnvironmentObject var appsSelectionVM: AppsSelectionVM
    @StateObject var scheduleVM = DeviceActivityScheduleVM()

    @State private var showAppsList: Bool = false
    @State private var activitySelection = FamilyActivitySelection()
    
    @State private var showAddAppGroup: Bool = false
    @State private var showSetSchedule: Bool = false
    
    @State private var openButton: Bool = false
    
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
//        .familyActivityPicker(isPresented: $showAppsList, selection: $appsSelectionVM.selection)
        .fullScreenCover(isPresented: $showAddAppGroup) {
            AppsConfigView(showAddAppConfig: $showAddAppGroup)
        }
        .fullScreenCover(isPresented: $showSetSchedule) {
            SetScheduleView(showSetSchedule: $showSetSchedule)
        }

    }
    
    private func SetupListView()-> some View {
        List {
            SetUpAppSelection()
            SetSchedule()
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
            
//            if appsSelectionVM.isSelectionEmpty() {
//                Text("No Applications selected")
//                    .foregroundColor(Color.secondary)
//            } else {
//                ForEach(Array(appsSelectionVM.selection.applicationTokens), id: \.self) { token in
//                    Label(token)
//
//                }
//                ForEach(Array(appsSelectionVM.selection.categoryTokens), id: \.self) { token in
//                    Label(token)
//                }
//                ForEach(Array(appsSelectionVM.selection.webDomainTokens), id: \.self) { token in
//                    Label(token)
//                }
//            }
            
        }
    }
    
    private func SetSchedule() -> some View {
        
        Section {
            Button(action: {
                self.showSetSchedule = true
            }, label: {
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        SFSymbol(iconName: "hourglass.badge.plus", size: .largeTitle, weight: .medium, fgColor: .blue, renderingMode: .hierarchical)
                        TextModifier(text: "Set a Shedule for your selected Applications", fontConfig: .textStyle(style: .headline, weight: .semibold, design: .rounded), fgColor: .primary, alignment: .center, lineLimit: 100)
                        
                    }
                    Spacer()
                }
                .padding(.vertical)
            })
            
        } header: {
            HStack {
                HStack {
                    TextModifier(text: "Set a Shedule", fontConfig: .textStyle(style: .footnote, weight: .semibold, design: .default), fgColor: .secondary, alignment: .leading, lineLimit: 2)
                    
                    Spacer()

                }
            }
        } footer: {
            Text("Schedule Stats now")
        }
        
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
            .environmentObject(AppsSelectionVM())
    }
}
