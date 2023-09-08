//
//  ApplicationManager.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import AppIntents
import CoreData
import UIKit

class AppManager {
    
    static let shared = AppManager()
    
    func getAllApps() -> [ApplicationEntity] {
        return ApplicationEntity.allApplications
    }
    
    func findApp(withId identifier: UUID) throws -> ApplicationEntity? {
//        ApplicationEntity.allApplications.filter { $0.appName == searchName }
        return ApplicationEntity.allApplications.first(where: { $0.id == identifier })
    }
}
