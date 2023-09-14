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
import DeviceActivity

let APP_GROUP_NAME = Bundle.main.APP_GROUP_NAME

class AppsConfigVM: ObservableObject {
     
    @Published var loadedAppConfigs: [AppConfig] = []
    
    @Published var isAddingAppGroup: Bool = false
    @Published var isLoadingAppGroup: Bool = false
    
    @Published var selection: FamilyActivitySelection = FamilyActivitySelection()
    
    func addAppConfigToProtection(_ appConfig: AppConfig) {
        Task {
            do {
                print("Saving AppConfig")
                let key = "appConfig_applicationToken_\(appConfig.id)"
                if let encoded = try? JSONEncoder().encode(appConfig) {
                    UserDefaults.standard.set(encoded, forKey: key)
                }
                
                saveSelection(appConfig: appConfig)
                
            } catch {
                print("Could not add App for protection: \(error.localizedDescription)")
            }
        }
    }
    
    func saveSelection(appConfig: AppConfig) {
        do {
            print("Saving FamilyActivitySelection")
            print("Saving TOKEN: \(String(describing: appConfig.familyActivitySelection.applicationTokens.first?.hashValue))")
            
//            guard let id = appConfig.id else { return }
            
            let data = try JSONEncoder().encode(appConfig.familyActivitySelection)
            UserDefaults.group()?.setValue(
                data,
                forKey: DeviceActivityName.fromId(String(appConfig.id)).rawValue
            )
            
            DeviceActivityService.shared.startMonitoring(appConfig: appConfig)
            
        } catch {
            print(error)
        }
    }
    
    func deleteAppConfigFromProtection(_ appConfig: AppConfig) {
        Task {
            do {
                print("Deleting AppConfig")
                let key = "appConfig_applicationToken_\(appConfig.id)"
                UserDefaults.standard.removeObject(forKey: key)
                
                deleteSelection(appConfig: appConfig)
                
            } catch {
                print("Could not delete App for protection: \(error.localizedDescription)")
            }
        }
    }
    
    
    func deleteSelection(appConfig: AppConfig) {
        do {
            print("Deleting FamilyActivitySelection")
//            guard let id = appConfig.id else { return }
            
            let activityKey = DeviceActivityName.fromId(String(appConfig.id)).rawValue
            UserDefaults.group()?.removeObject(forKey: activityKey)
            
            print("Stopping to Monitor upon deletion")
            DeviceActivityService.shared.stopMonitoring(appConfig: appConfig)
            
        } catch {
            print(error)
        }
    }
    
    func loadAppConfigs() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if key.hasPrefix("appConfig_applicationToken_") {
                if let data = UserDefaults.standard.data(forKey: key),
                   let decoded = try? JSONDecoder().decode(AppConfig.self, from: data) {
                    print("TOKEN: For \(decoded.appName) from List: \(decoded.id)")
                    loadedAppConfigs.append(decoded)
                }
            }
        }
    }
}

extension UserDefaults {
    static func group() -> UserDefaults? {
        return UserDefaults(
            suiteName: "group.com.EvilEye.EvilEye-IOS.shared"
        )
    }
}


extension FamilyActivitySelection {
    static func fromKey(_ key: String) -> FamilyActivitySelection {
        if let data = UserDefaults.group()?.data(forKey: key),
           let selection = try? JSONDecoder().decode(
            FamilyActivitySelection.self,
            from: data
        )  {
            return selection
        } else {
            return FamilyActivitySelection(includeEntireCategory: false)
        }
    }
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
