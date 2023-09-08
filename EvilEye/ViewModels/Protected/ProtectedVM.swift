//
//  ProtectedVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/7/23.
//

import Foundation

class ProtectedVM: ObservableObject {
    
    @Published var appConfig: AppConfig?
    @Published var getAppConfigProcess: Process = .notProcessing {
        didSet {
            print("Getting AppConfig: \(getAppConfigProcess)")
        }
    }
    let errorMsg = "Konnte nicht geladen werden"
    
//    init(token: String) {
//       getAppConfig(token)
//    }
    
    func getAppConfig(_ token: String) {
        
        let key = "appConfig_applicationToken_\(token)"
        
        // Retrieve data from UserDefaults
        if let savedData = UserDefaults.standard.data(forKey: key) {
            
            // Decode and update @Published variable
            do {
                let decodedAppConfig = try JSONDecoder().decode(AppConfig.self, from: savedData)
                
                DispatchQueue.main.async {
                    self.appConfig = decodedAppConfig
                }
                
            } catch {
                print("Could not decode AppConfig: \(error.localizedDescription)")
            }
        }
    }
}
