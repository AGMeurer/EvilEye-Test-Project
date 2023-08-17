//
//  ShieldActionExtension.swift
//  ShieldAction
//
//  Created by Alexander Meurer on 8/17/23.
//

import ManagedSettings
import UIKit
import SwiftUI

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        
        switch action {
        case .primaryButtonPressed:
            print("Primary Button Pressed")

            if let url = URL(string: "evileye://") {
                let context = NSExtensionContext()
                context.open(url, completionHandler: nil)
            }
            completionHandler(.defer)

        case .secondaryButtonPressed:
            
            completionHandler(.close)
            
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        print("PRESSED")
        completionHandler(.close)
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        print("PRESSED")
        completionHandler(.close)
    }
}
