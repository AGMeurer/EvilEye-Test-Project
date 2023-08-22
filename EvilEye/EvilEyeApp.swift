//
//  EvilEyeApp.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI
import FamilyControls
import FirebaseCore

@main
struct EvilEyeApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    ///- Note: Observing scene Phases
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var  familyControlsVM = FamilyControlsVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(familyControlsVM)
                
        }
        .onChange(of: scenePhase) { newPhase in
                        if newPhase == .inactive {
                            print("Scene Phase: Inactive")
                        } else if newPhase == .active {
                           
                            Task { await familyControlsVM.requestFamilyControlAuthorization(initial: true) }
                        } else if newPhase == .background {
                            print("Scene Phase: Background")
                        }
                    }
        
    }
}

class AppDelegate: NSObject,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
    
    // MARK: Phone Auth Needs to Intialize Remote Notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL else {
            return false
        }

        // Handle the URL here, e.g. by parsing it and navigating to the appropriate view
        // ...

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "evileye" {
            // Handle the URL
            print("ARRIVED HERE")
            return true
        }
        return false
    }
}

