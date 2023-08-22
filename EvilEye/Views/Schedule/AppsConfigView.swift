//
//  ScreenTimeSelectAppsView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI
import FamilyControls

struct AppsConfigView: View {
    
    @StateObject var appGroupVM = AppsConfigVM()
    @Binding var showAddAppConfig: Bool
    
    var body: some View {
        NavigationSceleton(navigationBarTitle: "Apps", subTitle: "Manage your protected Applications", navbarDisplayMode: .large, contentWrapper: .noWrapper, navType: .navigationView) {
            
            ///- Note: Content
            if !appGroupVM.loadedAppConfigs.isEmpty {
//                ListOfAppConfigs()
            } else {
                ProgressView()
                    .scaleEffect(2)
            }

        } bottomContent: {
//            ///- Note: Bottom Content
//            Button(action: {
//                self.appGroupVM.
//            }, label: {
//                PrimaryButtonLabel(buttonText: "Add App Group", buttonState: .isEligible, isProgressing: false)
//            })
        } navbarLargeContent: {
            
        } navbarLeading: {
            SFSymbolWithButtonAction(iconName: "chevron.down", size: .headline, weight: .semibold, fgColor: .primary, renderingMode: .hierarchical) {
                
                self.showAddAppConfig = false
            }
           
        } navbarCenter: {
            
        } navbarTrailing: {
            SFSymbolWithButtonAction(iconName: "plus", size: .headline, weight: .bold, fgColor: .blue, renderingMode: .hierarchical) {
                self.appGroupVM.showFamilyPicker = true
            }
        }
        .familyActivityPicker(isPresented: $appGroupVM.showFamilyPicker, selection: $appGroupVM.selection)
//        .sheet(isPresented: $appGroupVM.showAddAppConfigSheet) {
//           SheetContent()
//                .presentationDragIndicator(.visible)
//                .presentationBackground(.ultraThinMaterial)
//                .presentationDetents([.medium])
//        }
//        .task {
//           await appGroupVM.loadAppGroups()
//        }

    }
    
    private func ListOfAppConfigs()-> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(appGroupVM.loadedAppConfigs, id: \.id) { config in
                    
                    AppGroupCell(appGroupConfig: .list(appGroup: config))
                    
                }
            }
            .padding(.vertical)
        }
    }
    
    private func AppGroupRow(_ appConfig: AppConfig)-> some View {
        VStack(alignment: .leading) {
//            TextModifier(text: appConfig.selectionName, fontConfig: .textStyle(style: .title3, weight: .semibold, design: .rounded), fgColor: .blue, alignment: .leading, lineLimit: 2)
            
//            HStack {
//                VStack {
//                    ForEach(Array(appConfig.selection), id: \.self) { token in
//                        Label(token)
//                        
//                    }
//                    
//                    ForEach(Array(appConfig.selection.categoryTokens), id: \.self) { token in
//                        Label(token)
//                    }
//                    
//                    ForEach(Array(appConfig.selection.webDomainTokens), id: \.self) { token in
//                        Label(token)
//                    }
//                }
//                Spacer()
//            }
//            .padding()
//            .background {
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(.ultraThinMaterial)
//            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func SheetContent()-> some View {
        VStack(alignment: .leading) {
            FocusedTextField(text: $appGroupVM.name, headline: "Give your group a name", placeholder: "Example: Social Media", keyboardType: .default)
            
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(Array(appGroupVM.activeSelection.applicationTokens), id: \.self) { token in
//                        Label(token)
//                            .padding()
//                            .background {
//                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(.ultraThinMaterial)
//                            }
//
//                    }
//
//                    ForEach(Array(appGroupVM.activeSelection.categoryTokens), id: \.self) { token in
//                        Label(token)
//                            .padding()
//                            .background {
//                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(.ultraThinMaterial)
//                            }
//                    }
//
//                    ForEach(Array(appGroupVM.activeSelection.webDomainTokens), id: \.self) { token in
//                        Label(token)
//                            .padding()
//                            .background {
//                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(.ultraThinMaterial)
//                            }
//                    }
//
//                }
//                .padding()
//            }
            
            Button(action: {

//                Task { await appGroupVM.saveAppGroup(appGroupVM.activeSelection) }
                
            }, label: {
                PrimaryButtonLabel(buttonText: "Add Group", buttonState: .isEligible, isProgressing: appGroupVM.isAddingAppGroup)
            })
            .padding(.top)
        }
    }
}

struct ManageAppGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsConfigView(showAddAppConfig: .constant(false))
    }
}
