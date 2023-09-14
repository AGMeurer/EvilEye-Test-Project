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
    
    ///- Note: App Delegate
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    ///- Note: Observing scene Phases
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var  familyControlsVM = FamilyControlsVM()
    @ObservedObject var protectionVM = ProtectionVM.shared
    
    var body: some Scene {
        WindowGroup {
            ///- Note: Main Content
            ContentView()
            ///- Note: FullscreenCover that will display when redirecting from Protected App
                .fullScreenCover(isPresented: $protectionVM.openProtectionScreen, content: {
                    Text(protectionVM.app?.appName ?? "No App Found")
                })
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

//class AppDelegate: NSObject,UIApplicationDelegate, UNUserNotificationCenterDelegate{
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // ...
//
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            // Handle permission granted or not
//        }
//        center.delegate = self
//
//        return true
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        if let userInfo = response.notification.request.content.userInfo as? [String: AnyObject],
//           let urlStr = userInfo["url"] as? String,
//           let url = URL(string: urlStr),
//           url.scheme == "evileye" {
//
//            if let token = url.queryItems?.first(where: { $0.name == "token" })?.value {
//                print("TOKEN: From Shield: \(token)")
//                NotificationCenter.default.post(name: NSNotification.Name("OpenSheet"), object: nil, userInfo: ["token": token])
//            }
//        }
//
//        completionHandler()
//    }
//}
//
//extension URL {
//    var queryItems: [URLQueryItem]? {
//        return URLComponents(string: self.absoluteString)?.queryItems
//    }
//}

