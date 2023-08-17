//
//  FamilyControlsVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import FamilyControls
import Combine
import SwiftUI

///- Note: VM is used to request and manage Authorization status to the ScreenTime API
class FamilyControlsVM: ObservableObject {
    
    ///- Note: Instance of Authorization Center
    @Published var authorizationStatus: AuthorizationStatus = .notDetermined
    @Published var center = AuthorizationCenter.shared
    ///- Note: Programatically triggers request
    @Published var triggerAuthRequest: Bool = false
    ///- Note: Display alert when denied Access
    @Published var userDidNotAllow: Bool = false

    func requestFamilyControlAuthorization(initial: Bool) async {
        Task {
            do {
                
                await MainActor.run(body: {
                    print("Requesting Family Control Authorization")
                    withAnimation { self.userDidNotAllow = false }
                })
                
                //- Request Status
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                
                await MainActor.run(body: {
                    //- Saving status
                    withAnimation {
                        authorizationStatus = AuthorizationCenter.shared.authorizationStatus
                    }
                    print("Auth Status: \(authorizationStatus.description)")
                })
                
            } catch {
                
                await MainActor.run(body: {
                    withAnimation { self.userDidNotAllow = true }
                })
                
                print("Failed to enroll with error: \(error)")
            }
        }
    }
    
    func checkAuth() {
        switch center.authorizationStatus {
        case .notDetermined:
            print("Denied")
        case .denied:
            print("Denied")
        case .approved:
            print("Approved")
        
        @unknown default:
            fatalError()
        }
        
        
    }
    
//    func checkAuthorizationStatus() {
//        let cancellable = center.$authorizationStatus
//            .sink() {_ in
//                switch self.center.authorizationStatus {
//            case .notDetermined:
//                print("Not Determined")
//                    Task { await self.requestFamilyControlAuthorization() }
//                // Handle the change to notDetermined.
//            case .denied:
//                // Handle the change to denied.
//                print("Determined")
//            case .approved:
//                // Handle the change to approved.
//                print("Approved")
//                @unknown default:
//                    fatalError()
//                }
//        }
//    }
}
