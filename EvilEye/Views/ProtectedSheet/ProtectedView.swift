//
//  ProtectedView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/7/23.
//

import SwiftUI

struct ProtectedView: View {
    
    let token: String
    
    @State private var appConfig: AppConfig?
    
    var body: some View {
        Group {
            if let appConfig = appConfig {
                VStack {
                    TextModifier(text: "You have surpassed your limit for \(appConfig.appName) ", fontConfig: .textStyle(style: .title, weight: .bold, design: .default), fgColor: .primary, alignment: .center, lineLimit: 5)

                    TextModifier(text: "Want to get more time?", fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: .secondary, alignment: .center, lineLimit: 2)
                }
                .padding()
            } else {
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .onAppear {
            print(token)
            getAppConfig(token)
        }
    }
    
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

struct ProtectedView_Previews: PreviewProvider {
    static var previews: some View {
        ProtectedView(token: "")
    }
}
