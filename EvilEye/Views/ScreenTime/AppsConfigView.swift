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
        NavigationSceleton(navigationBarTitle: "Apps", subTitle: "Manage your protected Applications", navbarDisplayMode: .large, contentWrapper: .scrollView, navType: .navigationView) {

                ProtectedApps()
                InitialAppConfigs()
          
        } bottomContent: {

        } navbarLargeContent: {
            Logo(size: 70)
        } navbarLeading: {
            SFSymbolWithButtonAction(iconName: "chevron.down", size: .headline, weight: .semibold, fgColor: .primary, renderingMode: .hierarchical) {
                
                self.showAddAppConfig = false
            }
           
        } navbarCenter: {
            
        } navbarTrailing: {

        }
        .task {
            self.appGroupVM.loadAppConfigs()
        }
    }
    
    ///- Note: Initial App Configs (no Token)
    @ViewBuilder
    func InitialAppConfigs()-> some View {
        
        LazyVStack(alignment: .leading, spacing: 10) {
            TextModifier(text: "Add Applications", fontConfig: .textStyle(style: .title3, weight: .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 2)
            ForEach(AppConfig.initialAppConfigs, id: \.id) { appConfig in
                
                if appGroupVM.loadedAppConfigs.contains(where: { $0.appName == appConfig.appName }) {
                    
                } else {
                    AddAppCell(appConfig: appConfig) { configWithToken in
                        ///- Note: Upload Config to User Defaults
                        self.appGroupVM.addAppConfigToProtection(configWithToken)
                        
                        ///- Note: Append locally
                        withAnimation {
                            self.appGroupVM.loadedAppConfigs.append(configWithToken)
                        }
                    }
                }
            }
        }
        .padding([.vertical, .horizontal])
    }
    
    @ViewBuilder
    func ProtectedApps() -> some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            TextModifier(text: "Protected Applications", fontConfig: .textStyle(style: .title3, weight: .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 2)
            
            if !appGroupVM.loadedAppConfigs.isEmpty {
                ForEach(appGroupVM.loadedAppConfigs, id: \.self) { appConfig in
                    AppCell(config: .normal(appConfig: appConfig, action: {
                        
                        ///- Note: Delete Config from User Defaults
                        appGroupVM.deleteAppConfigFromProtection(appConfig)
                        
                        ///- Note: Remove locally
                        withAnimation {
                            self.appGroupVM.loadedAppConfigs.removeAll(where: {$0.id == appConfig.id})
                        }
                        
                    }))
                    
                }
                
            } else {
                TextModifier(text: "No Apps to protect", fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: .secondary, alignment: .leading, lineLimit: 2)
            }
        }
        .padding([.vertical, .horizontal])
    }
}

struct ManageAppGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsConfigView(showAddAppConfig: .constant(false))
    }
}
