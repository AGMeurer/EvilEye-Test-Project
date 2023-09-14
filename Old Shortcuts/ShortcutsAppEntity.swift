////
////  ShortcutsAppEntity.swift
////  EvilEye
////
////  Created by Alexander Meurer on 9/3/23.
////
//
//import Foundation
//import AppIntents
//import SwiftUI
//
//struct ShortcutsAppEntity: Identifiable, Hashable, Equatable, AppEntity {
//    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Application")
//    
//    typealias DefaultQueryType = IntentsAppQuery
//    static var defaultQuery: IntentsAppQuery = IntentsAppQuery()
//    
//    var id: UUID
//    
//    @Property(title: "App Name")
//    var appName: String
//    
//    //@Property(title: "App Icon")
//    var appIcon: IntentFile?
//    
//    init(id: UUID, appName: String, appIconData: Data?) {
//
//        self.id = id
//        self.appName = appName
////        if let appIconData {
////            self.appIcon = IntentFile(data: appIconData, filename: "\(appName)")
////        }
//        
//    }
//    
//    var displayRepresentation: DisplayRepresentation {
//        return DisplayRepresentation(
//            title: "\(appName)",
//            subtitle: "Mobile Application",
//            image: appIcon == nil ? .init(systemName: "app.dashed") : .init(data: appIcon!.data)
//        )
//    }
//}
//
//extension ShortcutsAppEntity {
//    
//    // Hashable conformance
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    // Equtable conformance
//    static func ==(lhs: ShortcutsAppEntity, rhs: ShortcutsAppEntity) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//}
//
//extension ShortcutsAppEntity {
//    static let allApps: [ShortcutsAppEntity] = [
//        ShortcutsAppEntity(id: UUID(), appName: "Instagram", appIconData: nil),
//        ShortcutsAppEntity(id: UUID(), appName: "Facebook", appIconData: nil),
//        ShortcutsAppEntity(id: UUID(), appName: "Snapchat", appIconData: nil),
//    ]
//}
//
//struct IntentsAppQuery: EntityPropertyQuery {
//    
//    func entities(matching comparators: [NSPredicate], mode: ComparatorMode, sortedBy: [EntityQuerySort<ShortcutsAppEntity>], limit: Int?) async throws -> [ShortcutsAppEntity] {
//        
//        return ShortcutsAppEntity.allApps
//        
////        ApplicationEntity.allApplications.compactMap { i  in
////            return ShortcutsAppEntity(
////                id: i.id,
////                appName: i.appName,
////                appIconData: i.appIconData
////            )
////        }
//    }
//    
//    
//    static var properties = EntityQueryProperties<ShortcutsAppEntity, NSPredicate> {
//        Property(\ShortcutsAppEntity.$appName) {
//            EqualToComparator { NSPredicate(format: "appName = %@", $0) }
//            ContainsComparator { NSPredicate(format: "appName CONTAINS %@", $0) }
//
//        }
//    }
//    
//    static var sortingOptions = SortingOptions {
//        SortableBy(\ShortcutsAppEntity.$appName)
//    }
//    
//    
//    func entities(for identifiers: [UUID]) async throws -> [ShortcutsAppEntity] {
//        //            return identifiers.compactMap { SessionManager.session(for: $0) }
//        return ShortcutsAppEntity.allApps
////        return identifiers.compactMap { identifier in
////            if let match = try? AppManager.shared.findApp(withId: identifier) {
////                return ShortcutsAppEntity(
////                    id: match.id,
////                    appName: match.appName,
////                    appIconData: match.appIconData
////                )
////            } else {
////                return nil
////            }
////        }
//        
//        func suggestedEntities() async throws -> [ShortcutsAppEntity] {
//            return ShortcutsAppEntity.allApps
////            ApplicationEntity.allApplications.compactMap { i  in
////                return ShortcutsAppEntity(
////                    id: i.id,
////                    appName: i.appName,
////                    appIconData: i.appIconData
////                )
////            }
//        }
//        
//        func entities(matching comparators: [NSPredicate], mode: ComparatorMode, sortedBy: [EntityQuerySort<ShortcutsAppEntity>], limit: Int?) async throws -> [ShortcutsAppEntity] {
//            
//            return ShortcutsAppEntity.allApps
////            let matchingApps = ApplicationEntity.allApplications
////            return matchingApps.map {
////                ShortcutsAppEntity(id: $0.id, appName: $0.appName, appIconData: $0.appIconData)
////            }
//        }
//    }
//    
//}
////
////    func entities(for identifiers: [UUID]) async throws -> [ShortcutsAppEntity] {
//////            return identifiers.compactMap { SessionManager.session(for: $0) }
////
////        return identifiers.compactMap { identifier in
////            if let match = try? AppManager.shared.findApp(withId: identifier) {
////                return ShortcutsAppEntity(
////                    id: match.id,
////                    appName: match.appName,
////                    appIconData: match.appIconData
////                )
////            } else {
////                return nil
////            }
////        }
////
////    func suggestedEntities() async throws -> [ShortcutsAppEntity] {
////           return  ApplicationEntity.allApplications
////       }
//    
//
////
////    func entities(for identifiers: [UUID]) async throws -> [ShortcutsAppEntity] {
////
////        return identifiers.compactMap { identifier in
////            if let match = try? AppManager.shared.findApp(withId: identifier) {
////                return ShortcutsAppEntity(
////                    id: match.id,
////                    appName: match.appName,
////                    appIconData: match.appIconData
////                )
////            } else {
////                return nil
////            }
////        }
////    }
////
////    static var sortingOptions = SortingOptions {
////        SortableBy(\ShortcutsAppEntity.$appName)
////    }
////
////    static var properties = EntityQueryProperties<ShortcutsAppEntity, NSPredicate> {
////        Property(\ShortcutsAppEntity.$appName) {
////            EqualToComparator { NSPredicate(format: "appName = %@", $0) }
////            ContainsComparator { NSPredicate(format: "appName CONTAINS %@", $0) }
////
////        }
////    }
////}
