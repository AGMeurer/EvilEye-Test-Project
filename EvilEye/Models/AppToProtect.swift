//
//  ProtectedApp.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/13/23.
//

import Foundation
import AppIntents

///- Note: All Apps that can be selected for being protected, but are not protected yet

///- Note: This is the minimal implementation of Protected App. ProtectedApp isn't a Siri custom type, its actually just a normal Swift model with some protocol conformances! To make a model capable of being used like this in an intent, we just conform to AppEntity.
struct AppToProtect: Equatable, Hashable, AppEntity {
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Protect")
    
    typealias DefaultQueryType = AppQuery
    static var defaultQuery: AppQuery = AppQuery()
    
    static var typeDisplayName: LocalizedStringResource = LocalizedStringResource("App", defaultValue: "App")
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: .init(stringLiteral: name))
    }
    
    //- Custom Identifier
    let id: UUID
    // Name of the application
    let name: String

}

///- Note: A list of all Applications that the Use can choose to be protected
extension AppToProtect {
    static var all: [AppToProtect] = [
        AppToProtect(id: UUID(), name: "Instagram"),
        AppToProtect(id: UUID(), name: "TikTok"),
        AppToProtect(id: UUID(), name: "Snapchat"),
        AppToProtect(id: UUID(), name: "Youtube"),
        AppToProtect(id: UUID(), name: "Twitter"),

    ]
}

///- Note: Here's the minimal implementation of , which shows you a simple example of an EntityStringQuery
struct AppQuery: EntityStringQuery {
    typealias Entity = AppToProtect
    
    func entities(matching string: String) async throws -> [AppToProtect] {
        return AppToProtect.all.filter({ $0.name.starts(with: string) })
    }
    
    func entities(for identifiers: [UUID]) async throws -> [AppToProtect] {
        return AppToProtect.all.filter({ identifiers.contains($0.id) })
    }
}

