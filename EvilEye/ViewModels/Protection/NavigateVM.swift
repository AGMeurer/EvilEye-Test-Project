//
//  NavigateVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import Foundation
import SwiftUI

class NavigateVM: ObservableObject {
    
    static var shared = NavigateVM()
    
    @Published var selectedTab: Int = 0
    
    @Published var openSheet: Bool = false
    @Published var app: AppToProtect?
    
    @Published var token: String = ""
    
    ///- Note: This function determines, what will happen when the Shortcut gets triggered, and the Main Target opens
    func handleIntent(app: AppToProtect) {
        self.openSheet = true
        self.app = app
        
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
