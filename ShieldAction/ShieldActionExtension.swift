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
import MobileCoreServices
import AppIntents
import Social
import CoreServices
import UniformTypeIdentifiers

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
   
    static var openAppWhenRun: Bool = true // Make sure you have this
    
    let store = ManagedSettingsStore()
    
    func scheduleNotification(token: Int) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        let tokenAsString = String(token)
        content.title = "Open EvilEye"
        content.body = "Tap here."
        content.userInfo = ["url": "evileye://open?token=\(tokenAsString)"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "OpenURL", content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
        
    }
    
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        
        scheduleNotification(token: application.hashValue)
        
        completionHandler(.defer)
        
    }
    
    //    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
    //        switch action {
    //        case .primaryButtonPressed:
    //
    ////            if let url = URL(string: "https://www.youtube.com/") {
    ////                let extensionContext = NSExtensionContext()
    ////                extensionContext.open(url, completionHandler: nil)
    ////            }
    //
    //           completionHandler(.none)
    //
    //        case .secondaryButtonPressed:
    //
    //            if let url = URL(string: "https://www.youtube.com/") {
    //                let extensionContext = NSExtensionContext()
    //                extensionContext.open(url, completionHandler: nil)
    //            }
    //            completionHandler(.defer)
    //
    //        @unknown default:
    //            fatalError()
    //        }
    //    }
    //
    //    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
    //        switch action {
    //        case .primaryButtonPressed:
    //
    ////            if let url = URL(string: "https://www.youtube.com/") {
    ////                let extensionContext = NSExtensionContext()
    ////                extensionContext.open(url, completionHandler: nil)
    ////            }
    //
    //           completionHandler(.none)
    //
    //        case .secondaryButtonPressed:
    //
    //            if let url = URL(string: "https://www.youtube.com/") {
    //                let extensionContext = NSExtensionContext()
    //                extensionContext.open(url, completionHandler: nil)
    //            }
    //            completionHandler(.defer)
    //
    //        @unknown default:
    //            fatalError()
    //        }
    //    }
}


//
//    func redirect() {
//        let myURL = URL(string: "shortcuts://open-shortcut?name=[EvilEye]")!
//        let extensionItem = NSExtensionItem()
//        extensionItem.userInfo = [ NSExtensionJavaScriptFinalizeArgumentKey : [ "url" : myURL.absoluteString ]]
//
//        let extensionContext = NSExtensionContext()
//
//        extensionContext.completeRequest(returningItems: [extensionItem], completionHandler: nil)
//
//    }
