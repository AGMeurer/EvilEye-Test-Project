//
//  ShieldActionExtension.swift
//  ShieldAction
//
//  Created by Alexander Meurer on 8/17/23.
//

import ManagedSettings
import UIKit
import SwiftUI
import NotificationCenter
import ExtensionKit
import ExtensionFoundation

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
   
    let store = ManagedSettingsStore()

    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        
        switch action {
        case .primaryButtonPressed:
            
//            if let url = URL(string: "https://www.youtube.com/") {
//                let extensionContext = NSExtensionContext()
//                extensionContext.open(url, completionHandler: nil)
//            }

           completionHandler(.none)

        case .secondaryButtonPressed:
            completionHandler(.defer)
//            if let url = URL(string: "https://www.youtube.com/") {
//                let extensionContext = NSExtensionContext()
//                extensionContext.open(url, completionHandler: nil)
//            }
            
            
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            
//            if let url = URL(string: "https://www.youtube.com/") {
//                let extensionContext = NSExtensionContext()
//                extensionContext.open(url, completionHandler: nil)
//            }

           completionHandler(.none)

        case .secondaryButtonPressed:
            
            if let url = URL(string: "https://www.youtube.com/") {
                let extensionContext = NSExtensionContext()
                extensionContext.open(url, completionHandler: nil)
            }
            completionHandler(.defer)
            
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            
//            if let url = URL(string: "https://www.youtube.com/") {
//                let extensionContext = NSExtensionContext()
//                extensionContext.open(url, completionHandler: nil)
//            }

           completionHandler(.none)

        case .secondaryButtonPressed:
            
            if let url = URL(string: "https://www.youtube.com/") {
                let extensionContext = NSExtensionContext()
                extensionContext.open(url, completionHandler: nil)
            }
            completionHandler(.defer)
            
        @unknown default:
            fatalError()
        }
    }
}

extension ShieldActionResponse {
    
}
