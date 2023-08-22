//
//  AppGroupsVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import Foundation
import FamilyControls
import SwiftUI
import ManagedSettings

let APP_GROUP_NAME = Bundle.main.APP_GROUP_NAME

class AppsConfigVM: ObservableObject {
    
    @Published var loadedAppConfigs: [AppConfig] = []
    
    @Published var showFamilyPicker: Bool = false
    
//    @AppStorage("selection", store: UserDefaults(suiteName: APP_GROUP_NAME))
    
    var selection: FamilyActivitySelection = FamilyActivitySelection() {
        willSet {
            print("Will Set")
            let applications = newValue.applicationTokens
            let categories = newValue.categoryTokens
            
            addAppToken(applications)
            
        }
    }
    
    @Published var showAddAppConfigSheet: Bool = false
    @Published var name: String = ""
    @Published var icon: String = ""
    
    @Published var isAddingAppGroup: Bool = false
    @Published var isLoadingAppGroup: Bool = false
    
    func addAppToken(_ applications: Set<ApplicationToken>) {
        
        print("Adding App Config for Token")
        ///- Note: Check whether there is already a App Config for a specific Application
        for application in applications {
            
            print("TOKEN: \(application)")
            
            ///-Step 2: Check whether App Config for Application already exists
//            if !containsSpecificToken(appConfigs: loadedAppConfigs, specificToken: application) {
//
//                let uuid = UUID().uuidString
//                let config = AppConfig(id: uuid, selection: .applicationToken(token: application))
//
//                let key = "appConfig_applicationToken_\(uuid)"
//                if let encoded = try? JSONEncoder().encode(config) {
//                    UserDefaults.standard.set(encoded, forKey: key)
//                }
//
//            } else {
//                print("Config for Application with token: \(application) already exists")
//            }
        }
    }
    
    func addAppCategory(_categories: Set<Category>) {
        
    }
    
//    func saveAppConfig(_ appConfig: AppConfig) async {
//        print("Saving App Group")
//
//        do {
//
//            await MainActor.run(body: {
//                withAnimation {
//                    isAddingAppGroup = true
//                }
//            })
//
//            ///- Adding Id
//            let key = "appGroup_applicationToken_\(appConfig.id)"
//            let encodedData = try JSONEncoder().encode(appConfig)
//            UserDefaults.standard.set(encodedData, forKey: key)
//
//            await MainActor.run(body: {
//                withAnimation {
//                    isAddingAppGroup = false
//                    showAddAppConfigSheet = false
//
//                    name = ""
//                    icon = ""
//                    activeSelection = FamilyActivitySelection()
//                }
//            })
//
//        } catch {
//            print("Error encoding data: \(error)")
//        }
//    }
    
}

// MARK: - FamilyActivitySelection Parser
extension FamilyActivitySelection: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
