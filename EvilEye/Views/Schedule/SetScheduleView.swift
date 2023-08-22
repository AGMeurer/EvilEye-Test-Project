//
//  SetScheduleView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import SwiftUI
import DeviceActivity

struct SetScheduleView: View {
    @StateObject var setScheduleVM = SetScheduleVM()
    
    @Binding var showSetSchedule: Bool
    
    var isEligible: ButtonState {
        return .isEligible
    }
    
    var body: some View {
        NavigationSceleton(navigationBarTitle: "Create Schedules", subTitle: "Block Apps in a Time Interval", navbarDisplayMode: .large, contentWrapper: .list, navType: .navigationView) {
            ///- Note:

            VStack(spacing: 15) {
                FocusedTextField(text: $setScheduleVM.activityName, headline: "Name your Activity", placeholder: "Morning", keyboardType: .default)
            }
            
            ///- Note: App Group
            AddAppGroup()
            
            ///- Note: Day
            SelectDay()
            
            ///- Note: StartTime
            SelectStartTime()
            
            ///- Note: EndTime
            SelectEndTime()
            
        } bottomContent: {
            Button(action: {
                Task { await self.setScheduleVM.saveSchedule() }
            }, label: {
                PrimaryButtonLabel(buttonText: "Create Activiy", buttonState: isEligible, isProgressing: setScheduleVM.isAddingSchedule)
            })

        } navbarLargeContent: {
            
        } navbarLeading: {
            SFSymbolWithButtonAction(iconName: "chevron.down", size: .headline, weight: .semibold, fgColor: .primary, renderingMode: .hierarchical) {
                self.showSetSchedule = false
            }
        } navbarCenter: {
            
        } navbarTrailing: {
            
        }
        .task {
           await self.setScheduleVM.loadAppGroups()
        }
        .disableWithOpacity(setScheduleVM.isAddingSchedule)
        .onChange(of: setScheduleVM.hasAddedSchedule, perform: { newValue in
            self.showSetSchedule = false
        })
        .sheet(isPresented: $setScheduleVM.showAppGroups) {
            SelectAppGroup()
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $setScheduleVM.showStartTime) {
            
        }
        .sheet(isPresented: $setScheduleVM.showEndTime) {
            
        }
        

    }
    
    @ViewBuilder
    func AddAppGroup()-> some View {
//        Section {
//            Button(action: {
//                self.setScheduleVM.showAppGroups = true
//            }, label: {
//                HStack {
//                    VStack(alignment: .leading) {
//                        TextModifier(text: setScheduleVM.appGroup == nil ? "Select App Group" : setScheduleVM.appGroup?.selectionName ?? "", fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
//                        TextModifier(text: setScheduleVM.appGroup == nil ? "You have \(setScheduleVM.loadedAppGroups.count) App Groups" : "\(setScheduleVM.appGroup?.selection.applications.count) Applications", fontConfig: .textStyle(style: .footnote, weight: .medium, design: .default), fgColor: .secondary, alignment: .leading, lineLimit: 1)
//                    }
//                    Spacer()
//
//                    SFSymbol(iconName: "chevron.right", size: .headline, weight: .semibold, fgColor: .blue, renderingMode: .hierarchical)
//                }
//                .padding(.vertical, 10)
//            })
//
//        }
    }
    
    @ViewBuilder
    func SelectDay()-> some View {
        
        DatePicker(selection: $setScheduleVM.day, in: Date.now..., displayedComponents: .date) {
            Text("Select a date")
                .font(.system(.headline, weight: .semibold))
        }
        
    }
    
    @ViewBuilder
    func SelectStartTime()-> some View {
        
        DatePicker(selection: $setScheduleVM.startTime, in: Date.now..., displayedComponents: .hourAndMinute) {
            Text("Select a start time")
                .font(.system(.headline, weight: .semibold))
        }
        
    }
    
    @ViewBuilder
    func SelectEndTime()-> some View {
        DatePicker(selection: $setScheduleVM.endTime, in: (setScheduleVM.startTime.addingTimeInterval(15))..., displayedComponents: .hourAndMinute) {
            Text("Select a start time")
                .font(.system(.headline, weight: .semibold))
        }
    }
    
    @ViewBuilder
    func SelectAppGroup()-> some View {
//        NavigationSceleton(navigationBarTitle: "Select App Group", subTitle: "Select which App Group you would like to use for this Activity Schedule", navbarDisplayMode: .large, contentWrapper: .scrollView, navType: .navigationView) {
//
//            Group {
//                if setScheduleVM.isLoadingAppGroup {
//                    ProgressView()
//                } else if setScheduleVM.loadedAppGroups.isEmpty {
//                    VStack(spacing: 10) {
//                        SFSymbol(iconName: "apps.iphone.badge.plus", size: .largeTitle, weight: .semibold, fgColor: .primary, renderingMode: .hierarchical)
//                        TextModifier(text: "You have no App Groups", fontConfig: .textStyle(style: .title2, weight: .bold, design: .default), fgColor: .secondary, alignment: .center, lineLimit: 5)
//                    }
//                    .padding()
//
//                } else {
//                    VStack(spacing: 10) {
//                        ForEach(setScheduleVM.loadedAppGroups, id: \.selectionName) { appGroup in
//                            AppGroupCell(appGroupConfig: .list(appGroup: appGroup))
//                                .onTapGesture {
//                                    self.setScheduleVM.appGroup = appGroup
//                                    self.setScheduleVM.showAppGroups = false
//                                }
//                        }
//                    }
//                    .padding(.top)
//                }
//            }
//
//
//
//        } bottomContent: {
//
//        } navbarLargeContent: {
//
//        } navbarLeading: {
//
//        } navbarCenter: {
//
//        } navbarTrailing: {
//
//        }

    }
    
}

struct SetScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        SetScheduleView(showSetSchedule: .constant(true))
    }
}
