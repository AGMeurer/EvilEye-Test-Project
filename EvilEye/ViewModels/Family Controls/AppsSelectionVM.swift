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

let APP_GROUP_NAME = Bundle.main.APP_GROUP_NAME

class AppsSelectionVM: ObservableObject {

    let store = ManagedSettingsStore()
    
    @AppStorage("selection", store: UserDefaults(suiteName: APP_GROUP_NAME))
    var selection = FamilyActivitySelection() {
       
            willSet {
                print ("SET: Applications \(newValue.applications)")
                print("SET: TOKENS: \(newValue.applicationTokens)")
                let applications = newValue.applicationTokens
                let categories = newValue.categoryTokens
    //            let webCategories = newValue.webDomainTokens
                store.shield.applications = applications.isEmpty ? nil : applications
                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
                store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())

            }
    }
    
    ///- Note: Determine whether selection is empty or not
    func isSelectionEmpty() -> Bool {
        selection.applicationTokens.isEmpty &&
        selection.categoryTokens.isEmpty &&
        selection.webDomainTokens.isEmpty
    }
    
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
