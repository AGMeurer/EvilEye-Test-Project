//
//  OpenEvilEye.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import AppIntents
import SwiftUI

struct OpenAppFromApp: ForegroundContinuableIntent {
    
    // The name of the action in Shortcuts
    static var title: LocalizedStringResource = "Open New EvilEye"
    
    // Description of the action in Shortcuts
    // Category name allows you to group actions - shown when tapping on an app in the Shortcuts library
    static var description: IntentDescription = IntentDescription(
        """
        Open EvilEye instantly after you try to open a specific application

        """, categoryName: "Limit Access")
    
    // String input options allow you to set the keyboard type, capitalization and more
    @Parameter(title: "Application", description: "The Application you want to select", requestValueDialog: IntentDialog("Which Application would you like to choose?"), optionsProvider: AppSectionsOptionsProvider())
    var app: ShortcutsAppEntity
    
    private struct AppSectionsOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> ItemCollection<ShortcutsAppEntity> {
            let allApps = AppManager.shared.getAllApps().map {
                ShortcutsAppEntity(id: $0.id, appName: $0.appName, appIconData: $0.appIconData)
            }
            
            return ItemCollection {
                ItemSection(
                    title: "Mobile Applications",
                    items: allApps.map {
                        IntentItem<ShortcutsAppEntity>.init(
                            $0,
                            title: LocalizedStringResource(stringLiteral: $0.appName),
                            subtitle: LocalizedStringResource(stringLiteral: "Application"),
                            image: $0.appIcon == nil ? .init(systemName: "person") : .init(data: $0.appIcon!.data))
                    }
                )
            }
        }
    }
    
    // How the summary will appear in the shortcut action.
    // More parameters are included below the fold in the trailing closure. In Shortcuts, they are listed in the reverse order they are listed here
    static var parameterSummary: some ParameterSummary {
        Summary("I want to limit access for \(\.$app)") {
            \.$app
        }
    }
    
    static var openAppWhenRun: Bool = true // Make sure you have this
    
    @MainActor // <-- include if the code needs to be run on the main thread
    func perform() async throws -> some IntentResult {
        do {

//            NavigateVM.shared.navigateToMainApp(app: app)
            OpenAppFromApp.openAppWhenRun = false //- When

            return .result()
        } catch let error {
            throw error
        }
    }
}
