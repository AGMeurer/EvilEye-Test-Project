//
//  ProtectFromAppIntent.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/13/23.
//

import AppIntents

///- Note: Intent to go back from protected Application
struct ProtectFromAppIntent: AppIntent {
    
    ///- Note: Metadata
    static var title: LocalizedStringResource = "Protect from Test"
    static var description = IntentDescription("Protect yourself from the selected application", categoryName: "Protection")
    
    ///- Note: Opens Evil Eye Application upon action trigger
    static var openAppWhenRun: Bool = true
    
    ///- Note: String displayed in Intent Shortcuts App
    static var parameterSummary: some ParameterSummary {
        Summary("I want to limit access for \(\.$app)") {
            \.$app
        }
    }

    ///- Note: Parameter for the App to Protect
    @Parameter(title: "App you want to protect ⚠️🧿⚠️", description: "The application you want to protect", requestValueDialog: IntentDialog("Which application would you like to choose?"))
    var app: AppToProtect
    
    ///- Note: Runs code when the Intent is triggered
    @MainActor // 👈🏻 ensure it's executed in the main thread
    func perform() async throws -> some IntentResult {
        do {
            print("APP ID: \(app.id)")
            await ProtectionVM.shared.handleIntent(app: app)
            
            return .result()
        } catch {
            throw error
        }
    }
}

//  private struct AppOptionsProvider: DynamicOptionsProvider {
//      func results() async throws -> [AppToProtect] {
//          AppToProtect.all
//      }
//
//      func defaultResult() async -> AppToProtect? {
//          AppToProtect.all[0]
//      }
//  }
