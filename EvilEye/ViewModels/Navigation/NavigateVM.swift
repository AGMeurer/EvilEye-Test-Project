//
//  NavigateVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import Foundation
import SwiftUI

class NavigateVM: ObservableObject {
    
    @Published var selectedTab: Int = 0
    
    @Published var openSheet: Bool = false
    @Published var app: ShortcutsAppEntity?
    
    @Published var token: String = ""
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleOpenSheetNotification(_:)), name: NSNotification.Name("OpenSheet"), object: nil)
    }
    
    @objc func handleOpenSheetNotification(_ notification: Notification) {
        if let token = notification.userInfo?["token"] as? String {
            self.token = token
        }
        openSheet = true
    }
    
    func navigateToMainApp(app: ShortcutsAppEntity) {
        self.openSheet = true
        self.app = app
        
    }
}
