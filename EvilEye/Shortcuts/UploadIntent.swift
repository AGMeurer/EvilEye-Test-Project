//
//  UploadIntent.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/19/23.
//

import Foundation
import AppIntents

struct UploadIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Upload App"
    static var description = IntentDescription("Upload App", categoryName: "Upload")
    
    static var parameterSummary: some ParameterSummary {
        Summary("I want to limit access for \(\.$app)") {
            \.$app
        }
    }

    @Parameter(title: "App to upload", description: "The application you want to upload", requestValueDialog: IntentDialog("Which application would you like to choose?"))
    var app: AppToProtect
    
    @MainActor // 👈🏻 ensure it's executed in the main thread
    func perform() async throws -> some IntentResult {
        do {
            print("APP ID: \(app.id)")
//            await ProtectionVM.shared.handleIntent(app: app)
            
            return .result()
        } catch {
            throw error
        }
    }
}
