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
    
    let image = UIImage(named: "Small-Logo")
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        
        return ShieldConfiguration(
            backgroundBlurStyle: .systemUltraThinMaterialDark,
            icon: "🧿".image(with: CGSize(width: 30, height: 30)),
            title: ShieldConfiguration.Label(text: "Protected by Evil Eye", color: UIColor(Color.white)),
            subtitle: ShieldConfiguration.Label(text: "EvilEye helps you to reduce your screen time by protecting, not blocking you", color: UIColor(Color.white.opacity(0.7))),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Unlock more time", color: UIColor(Color.blue)),
            primaryButtonBackgroundColor: UIColor(Color.white)
           
        )
        
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration(
            backgroundColor: UIColor(Color.blue),
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

extension String {
    func image(with size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: size.height)
            ]
            
            let attributedString = NSAttributedString(string: self, attributes: attributes)
            let stringSize = attributedString.size()
            
            let x = (size.width - stringSize.width) / 3
            let y = (size.height - stringSize.height) / 3
            
            attributedString.draw(at: CGPoint(x: x, y: y))
        }
    }
}
