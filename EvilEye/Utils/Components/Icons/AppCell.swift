//
//  AppCell.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/22/23.
//

import SwiftUI

enum AppCellConfig {
    case normal(appConfig: AppConfig, action: () -> Void)
    case add(appConfig: AppConfig, addAppAction: () -> Void)
}

struct AppCell: View {
    
    let config: AppCellConfig
    
    var body: some View {
        switch config {
        case .normal(let appConfig, let action):
            Cell(appConfig: appConfig, action: action)
        case .add(let appConfig, let action):
            Cell(appConfig: appConfig, action:
            action)
        }
    }
    
    @ViewBuilder
    func Cell(appConfig: AppConfig, action: () -> Void)-> some View {
        HStack {
            AppIcon(icon: appConfig.appIcon, size: 30)
            TextModifier(text: appConfig.appName, fontConfig: .textStyle(style: .headline, weight:
                    .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
            Spacer()
            
            switch config {
            case .normal(_, let action):
                HStack {
                    
                    if let seconds = DeviceActivityService.shared.getThreshold(appConfig)?.second {
                        Text("\(seconds) sec")
                    }
                    
                    SFSymbolWithButtonAction(iconName: "pause.circle", size: .headline, weight: .semibold, fgColor: .red, renderingMode: .monochrome) {
                        action()
                        print("Action triggered")
                    }
                }
            case .add(_, let action):
                Button(action: {
                    action()
                }, label: {
                    Text("Add App")
                        .font(.system(.subheadline, weight: .medium))
                        .foregroundColor(.blue)
                })
                
            }
            
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial.opacity(0.5))
        }
        .padding(.horizontal)
    }
}

//struct AppCell_Previews: PreviewProvider {
//    static var previews: some View {
//        AppCell(config: .add(appConfig: AppConfig(appName: "Instagram", appIcon: instagram), addAppAction: {}))
//    }
//}
