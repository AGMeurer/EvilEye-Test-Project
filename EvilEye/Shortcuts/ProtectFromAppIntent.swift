//
//  ProtectFromAppIntent.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/13/23.
//

import AppIntents
import UIKit
import SwiftUI

//struct ProtectFromAppShortcut: AppShortcutsProvider {
//    @AppShortcutsBuilder static var appShortcuts: [AppShortcut] {
//        AppShortcut(intent: ProtectFromAppIntent(), phrases: ["Protect from application with \(.applicationName)"], shortTitle: "Protect", systemImageName: "eye.trianglebadge.exclamationmark.fill")
//    }
//}

///- Note: Intent to go back from protected Application
struct ProtectFromAppIntent: AppIntent {
    
    ///- Note: Metadata
    static var title: LocalizedStringResource = "Protect from App"
    static var description = IntentDescription("Protect yourself from the selected application", categoryName: "Protection")
    
    static var int: Int = 0
    
    static var openAppWhenRun: Bool = true
    
    ///- Note: String displayed in Intent Shortcuts App
    static var parameterSummary: some ParameterSummary {
        Summary("I want to limit access for \(\.$app)") {
            \.$app
        }
    }
    
    ///- Note: Parameter for the App to Protect
    @Parameter(title: "App you want to protect", description: "The application you want to protect", requestValueDialog: IntentDialog("Which application would you like to choose?"))
    var app: AppToProtect
    
    ///- Note: Runs code when the Intent is triggered
    @MainActor // 👈🏻 ensure it's executed in the main thread
    func perform() async throws -> some IntentResult & OpensIntent {
        do {
            
            await ProtectionVM.shared.handleIntent(app: app)
            
            return .result(opensIntent: NextAppIntent())
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

//@available(iOS 16.0, *)
struct NextAppIntent: AppIntent {
    
  static var title: LocalizedStringResource = "Next App Intent"

  @MainActor
  func perform(
  ) async throws -> some IntentResult {
      return .result()
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
