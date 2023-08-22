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

struct AppConfig: Codable {
    var id: String
    var selection: SelectionType
}

enum SelectionType: Codable, Equatable {
    case applicationToken(token: ApplicationToken)
    case applicationCategory(categoryToken: ActivityCategoryToken)

    // Equatable Conformance
    static func == (lhs: SelectionType, rhs: SelectionType) -> Bool {
        switch (lhs, rhs) {
        case (.applicationToken(let lhsToken), .applicationToken(let rhsToken)):
            return lhsToken == rhsToken
        case (.applicationCategory, .applicationCategory):
            return true
        default:
            return false
        }
    }
}

///- Checking if Array already contains ApplicationToken
func containsSpecificToken(appConfigs: [AppConfig], specificToken: ApplicationToken) -> Bool {
    for config in appConfigs {
        if case .applicationToken(let token) = config.selection {
            if token == specificToken {
                return true
            }
        }
    }
    return false
}

///- Note: Getting token from Config
func getToken(from config: AppConfig) -> ApplicationToken? {
    if case .applicationToken(let token) = config.selection {
        return token
    }
    return nil
}

///- Note: Getting category token from Config
func getCategoryToken(from config: AppConfig) -> ActivityCategoryToken? {
    if case .applicationCategory(let categoryToken) = config.selection {
        return categoryToken
    }
    return nil
}
