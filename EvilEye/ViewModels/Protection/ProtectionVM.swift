//
//  NavigateVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import Foundation
import SwiftUI

class ProtectionVM: ObservableObject {
    
    static var shared = ProtectionVM()

    ///- Note: This Bool opens the Protection FullScreenCover
    @Published var openProtectionScreen: Bool = false
    ///- Note: A list of all the applications the user protects
    @Published var protectedApps: [ProtectedApp] = []
    ///- Note: This property saves the Protected App associated with the app coming from the Intent
    @Published var protectedApp: ProtectedApp?
    ///- Note: Indicates that user added a new app to protect (important for adding new)
    @Published var addedNewProtectedApp: Bool = false
    ///- Note: User Defaults singleton for Protected Apps
    let defaults = UserDefaults.standard
    
    @Published var loadingAllProtectedAppsProcess: Process = .notProcessing {
        didSet { print("Handling Intent: \(loadingAllProtectedAppsProcess)")}
    }
    @Published var handleIntentProcess: Process = .notProcessing {
        didSet { print("Handling Intent: \(handleIntentProcess)")}
    }
    
    let protectedListError = "Could not load list of protected apps"
    let errorMsg = "Could not load protected App"
    
    ///- Note: This function determines, what will happen when the Shortcut gets triggered, and the Main Target opens
    func handleIntent(app: AppToProtect) async {
        Task {
            do {
                
                await updateUI { self.handleIntentProcess = .isProcessing }
                
                //- Checking if ProtectedApp with the AppToProtect ID already exists
                if defaults.object(forKey: "Protected_Apps_\(app.id)") == nil {
                    
                    print("Protected app with id: \(app.id) does not exists yet")
                    try await createProtectedApp(app)
                    try await getProtectedApp(app)
                    
                } else {
                    print("Protected app with id: \(app.id) exists")
                    try await getProtectedApp(app)
                }
                
                await updateUI {
                    self.handleIntentProcess = .success
                    self.openProtectionScreen = true
                }

            } catch {
                await updateUI{
                    self.handleIntentProcess = .failed(self.errorMsg)
                }
            }
        }
    }
    
    func createProtectedApp(_ app: AppToProtect) async throws {
        do {
            let protectedApp = ProtectedApp(id: app.id, appName: app.appName, appIcon: app.appName, openedCount: 1)
            let data = try JSONEncoder().encode(protectedApp)
            let key = "Protected_Apps_\(protectedApp.id)"
            UserDefaults.standard.set(data, forKey: key)
            //- So that the List of Apps is always up to date
            self.protectedApps.append(protectedApp)
        } catch {
            print("Failed to encode CustomObject: \(error.localizedDescription)")
        }
    }
    
    func getProtectedApp(_ app: AppToProtect) async throws {
        if let data = UserDefaults.standard.data(forKey: "Protected_Apps_\(app.id)") {
                do {
                    self.protectedApp = try JSONDecoder().decode(ProtectedApp.self, from: data)
                    print("Got Protected App named: \(String(describing: protectedApp?.appName))")
                } catch {
                    print("Failed to decode Protected App: \(error.localizedDescription)")
                }
            }
    }

    func updateProtectedApp() {
        
    }
    
    func loadAllProtectedApps() async {
        
        await updateUI {
            self.loadingAllProtectedAppsProcess = .isProcessing
        }
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if key.hasPrefix("Protected_Apps_") {
                if let data = UserDefaults.standard.data(forKey: key),
                   let decoded = try? JSONDecoder().decode(ProtectedApp.self, from: data) {
                    print("PROTECTED APPS: Found \(decoded.appName)")
                    protectedApps.append(decoded)
                }
            }
        }
        
        await updateUI {
            self.loadingAllProtectedAppsProcess = .success
        }
        
    }
    
//    init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleOpenSheetNotification(_:)), name: NSNotification.Name("OpenSheet"), object: nil)
//    }
//
//    @objc func handleOpenSheetNotification(_ notification: Notification) {
//        if let token = notification.userInfo?["token"] as? String {
//            self.token = token
//        }
//        openSheet = true
//    }
}
