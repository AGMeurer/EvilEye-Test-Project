//
//  ProtectFromAppIntent.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/13/23.
//

import AppIntents

struct ProtectFromAppIntent: AppIntent {
    
    ///- Note: Metadata
    static var title: LocalizedStringResource = "Protect from application"
    static var description = IntentDescription("Protect yourself from the selected application")
    
    ///- Note: Opens Evil Eye Application upon action trigger
    static var openAppWhenRun: Bool = true
    
    static var parameterSummary: some ParameterSummary {
        Summary("I want to limit access for \(\.$app)") {
            \.$app
        }
    }
    
    @Parameter(title: "App", optionsProvider: AppOptionsProvider())
    var app: AppToProtect
    
    private struct AppOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [AppToProtect] {
            AppToProtect.all
        }
    }
    
    func perform() async throws -> some IntentResult {
        NavigateVM.shared.handleIntent(app: app)
        return .result()
        }
}
