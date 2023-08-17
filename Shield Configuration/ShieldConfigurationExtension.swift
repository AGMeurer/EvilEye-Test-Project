//
//  ShieldConfigurationExtension.swift
//  Shield Configuration
//
//  Created by Alexander Meurer on 8/16/23.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit
import SwiftUI

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        ShieldConfiguration(
            backgroundBlurStyle: .systemMaterialDark,
            icon: UIImage(named: "Small-Logo"),
            title: ShieldConfiguration.Label(text: "Oii Cunt", color: UIColor(Color.blue)),
            subtitle: ShieldConfiguration.Label(text: "You better stop jerking off", color: UIColor(Color.white)),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Okay", color: UIColor(Color.white)),
            primaryButtonBackgroundColor: UIColor(Color.blue),
            secondaryButtonLabel: ShieldConfiguration.Label(text: "See app", color: UIColor(Color.white))
            )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration(
            backgroundBlurStyle: .systemUltraThinMaterial,
            icon: UIImage(named: "Small-Logo"),
            title: ShieldConfiguration.Label(text: "Stop watching", color: UIColor(Color.blue)),
            subtitle: ShieldConfiguration.Label(text: "You've spent enough time", color: UIColor(Color.primary)),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Okay", color: UIColor(Color.white)),
            primaryButtonBackgroundColor: UIColor(Color.blue),
            secondaryButtonLabel: ShieldConfiguration.Label(text: "See app", color: UIColor(Color.white))
            )
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration(
            backgroundBlurStyle: .systemUltraThinMaterial,
            icon: UIImage(named: "Logo"),
            title: ShieldConfiguration.Label(text: "Stop watching", color: UIColor(Color.blue)),
            subtitle: ShieldConfiguration.Label(text: "You've spent enough time", color: UIColor(Color.primary)),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Okay", color: UIColor(Color.white)),
            primaryButtonBackgroundColor: UIColor(Color.blue),
            secondaryButtonLabel: ShieldConfiguration.Label(text: "See app", color: UIColor(Color.white))
            )
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration(
            backgroundBlurStyle: .systemUltraThinMaterial,
            icon: UIImage(named: "Logo"),
            title: ShieldConfiguration.Label(text: "Stop watching", color: UIColor(Color.blue)),
            subtitle: ShieldConfiguration.Label(text: "You've spent enough time", color: UIColor(Color.primary)),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Okay", color: UIColor(Color.white)),
            primaryButtonBackgroundColor: UIColor(Color.blue),
            secondaryButtonLabel: ShieldConfiguration.Label(text: "See app", color: UIColor(Color.white))
            )
    }
}
