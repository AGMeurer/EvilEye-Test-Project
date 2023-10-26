//
//  ApplicationSelection.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

extension FamilyActivitySelection: Hashable {
 ///- Note: Just to make the Selection Hashable
}

struct AppConfig: Codable, Hashable {
    var id: Int
    var appName: String
    var appIcon: String
    var familyActivitySelection: FamilyActivitySelection
    var deviceActivityName: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(appName)
    }
}

// Am Anfang zeigen wir eine Liste mit allen AppConfigs an -> Dann listen wir alle hinzugefügten ganz oben
// Wenn AppConfig im Array zu finden ist, wir das in den initialAppConfigs nicht mehr angezeigt.
extension AppConfig {
    static let initialAppConfigs = [
        AppConfig(id: 0, appName: "Instagram", appIcon: instagram, familyActivitySelection: FamilyActivitySelection()),
        AppConfig(id: 1, appName: "Facebook", appIcon: facebook, familyActivitySelection: FamilyActivitySelection()),
        AppConfig(id: 2, appName: "Snapchat", appIcon: snapchat, familyActivitySelection: FamilyActivitySelection()),
        AppConfig(id:3, appName: "TikTok", appIcon: tikTok, familyActivitySelection: FamilyActivitySelection())
    ]
}

let instagram = "Instagram"
let facebook = "Facebook"
let tikTok = "TikTok"
let snapchat = "Snapchat"

// Function to save AppConfig array to UserDefaults
//func saveAppConf igsToUserDefaults(appConfigs: [AppConfig]) {
//    let encoder = JSONEncoder()
//    if let encoded = try? encoder.encode(appConfigs) {
//        UserDefaults.standard.set(encoded, forKey: "appConfigs")
//    }
//}
//
//// Function to load AppConfig array from UserDefaults
//func loadAppConfigsFromUserDefaults() -> [AppConfig]? {
//    if let savedAppConfigs = UserDefaults.standard.object(forKey: "appConfigs") as? Data {
//        let decoder = JSONDecoder()
//        if let loadedAppConfigs = try? decoder.decode([AppConfig].self, from: savedAppConfigs) {
//            return loadedAppConfigs
//        }
//    }
//    return nil
//}


/////- Checking if Array already contains ApplicationToken
//func containsSpecificToken(appConfigs: [AppConfig], specificToken: ApplicationToken) -> Bool {
//    for config in appConfigs {
//        if case .applicationToken(let token) = config.selection {
//            if token == specificToken {
//                return true
//            }
//        }
//    }
//    return false
//}
//
/////- Note: Getting token from Config
//func getToken(from config: AppConfig) -> ApplicationToken? {
//    if case .applicationToken(let token) = config.selection {
//        return token
//    }
//    return nil
//}
//
/////- Note: Getting category token from Config
//func getCategoryToken(from config: AppConfig) -> ActivityCategoryToken? {
//    if case .applicationCategory(let categoryToken) = config.selection {
//        return categoryToken
//    }
//    return nil
//}
