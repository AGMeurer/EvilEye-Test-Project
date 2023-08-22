//
//  ScreenTimeSelectAppsModel.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import SwiftUI
import FamilyControls
import Combine
import ManagedSettings

extension ManagedSettingsStore.Name {
    
    static func dynamicName(for key: String) -> ManagedSettingsStore.Name {
            if let storedValue = UserDefaults.standard.string(forKey: key) {
                return Self(storedValue)
            } else {
                fatalError("Name for key \(key) not found in UserDefaults!")
            }
        }
}

//let APP_GROUP_NAME = Bundle.main.APP_GROUP_NAME

class AppsSelectionVM: ObservableObject {

    let store = ManagedSettingsStore()
    
//    @AppStorage("selection", store: UserDefaults(suiteName: APP_GROUP_NAME))
//    var selection = FamilyActivitySelection()
//    {
       
//            willSet {
//                print ("SET: Applications \(newValue.applications)")
//                print("SET: TOKENS: \(newValue.applicationTokens)")
//                let applications = newValue.applicationTokens
//                let categories = newValue.categoryTokens
//    //            let webCategories = newValue.webDomainTokens
//                store.shield.applications = applications.isEmpty ? nil : applications
//                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//                store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//
//            }
//    }
    
    ///- Note: Determine whether selection is empty or not
//    func isSelectionEmpty() -> Bool {
//        selection.applicationTokens.isEmpty &&
//        selection.categoryTokens.isEmpty &&
//        selection.webDomainTokens.isEmpty
//    }
//
//
//    func setShieldRestrictions() {
//        let applications = selection.applicationTokens
//        let categories = selection.categoryTokens
//        // let webCategories = newValue.webDomainTokens
//        store.shield.applications = applications.isEmpty ? nil : applications
//        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//        store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//    }
    
//    var selectionToDiscourage = FamilyActivitySelection()
//    {
//        willSet {
//            print ("SET: Applications \(newValue.applications)")
//            print("SET: TOKENS: \(newValue.applicationTokens)")
//            let applications = newValue.applicationTokens
//            let categories = newValue.categoryTokens
////            let webCategories = newValue.webDomainTokens
//            store.shield.applications = applications.isEmpty ? nil : applications
//            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//            store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
////
//        }
//    }

}
