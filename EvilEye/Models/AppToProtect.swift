//
//  ProtectedApp.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/13/23.
//

import Foundation
import AppIntents
import UIKit

///- Note: All Apps that can be selected for being protected, but are not protected yet
///- Note: This is the minimal implementation of Protected App. ProtectedApp isn't a Siri custom type, its actually just a normal Swift model with some protocol conformances! To make a model capable of being used like this in an intent, we just conform to AppEntity.
struct AppToProtect: Identifiable, AppEntity {
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "App you want to protect ⚠️🧿⚠️")
    
    ///- Note: Determines which query will be used
    static var defaultQuery: Query = Query()
    
    ///- Note: Determines how AppToProtect Object will be displayed
    static var typeDisplayName: LocalizedStringResource = "Select Application"
    var displayRepresentation: AppIntents.DisplayRepresentation {
      DisplayRepresentation(
        title: "\(appName)",
        image: appIcon == nil ? .init(systemName: "book.closed") : .init(data: appIcon!.data)
      )
    }
    
    ///- Note: Properties
    //- Custom Identifier
    let id: String
    //- Name of the application
    let appName: String
    //- App Icon
    let appIcon: IntentFile?

}

///- Note: A list of all Applications that the Use can choose to be protected
extension AppToProtect {
    static var all: [AppToProtect] = [
        AppToProtect(id: "instagram", appName: "Instagram", appIcon: IntentFile(data: imageData(fromImageNamed: "Instagram") ?? Data(), filename: "INS")),
        AppToProtect(id: "tiktok", appName: "TikTok", appIcon:IntentFile(data: imageData(fromImageNamed: "TikTok") ?? Data(), filename: "TIK")),
        AppToProtect(id: "snapchat", appName: "Snapchat", appIcon:IntentFile(data: imageData(fromImageNamed: "Snapchat") ?? Data(), filename: "SNAP")),
        AppToProtect(id: "youtube", appName: "Youtube", appIcon:IntentFile(data: imageData(fromImageNamed: "Youtube") ?? Data(), filename: "YOU")),
        AppToProtect(id: "twitter", appName: "Twitter (X)", appIcon:IntentFile(data: imageData(fromImageNamed: "X") ?? Data(), filename: "TWIT")),
        
    ]
}

///- Note: Here's the minimal implementation of , which shows you a simple example of an EntityStringQuery
struct Query: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [AppToProtect] {
        return AppToProtect.all.filter({ identifiers.contains($0.id) })
    }
    
    func suggestedEntities() async throws -> [AppToProtect] {
        return AppToProtect.all
    }
}

//struct AppQuery: EntityStringQuery {
//    typealias Entity = AppToProtect
//
//    func entities(matching string: String) async throws -> [AppToProtect] {
//        return AppToProtect.all.filter({ $0.name.starts(with: string) })
//    }
//
//    func entities(for identifiers: [UUID]) async throws -> [AppToProtect] {
//        return AppToProtect.all.filter({ identifiers.contains($0.id) })
//    }
//}

func imageData(fromImageNamed imageName: String) -> Data? {
    guard let image = UIImage(named: imageName) else {
        print("Image not found!")
        return nil
    }
    
    guard let data = image.pngData() else {
        print("Could not convert image to Data!")
        return nil
    }
    
    return data
}
