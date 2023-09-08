//
//  AddAppCell.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/22/23.
//

import SwiftUI
import ManagedSettings
import FamilyControls
import Combine

struct AddAppCell: View {
    
    var appConfig: AppConfig
    let addTokenAction: (AppConfig) -> Void
    
    @State private var selection: FamilyActivitySelection = FamilyActivitySelection()
    @State private var openPicker: Bool = false
    
    var state: SelectionState {
        if selection.applicationTokens.count == 0 {
            return .selectedNone
        } else if selection.applicationTokens.count == 1 {
            return .selectedOne
        } else {
            return .selectedMoreThanOne
        }
    }
    
    enum SelectionState: String {
        case selectedNone = "Select Application"
        case selectedOne = "Add Application"
        case selectedMoreThanOne = "Selected more than 1"
        
        var text: String {
            return self.rawValue
        }
        
        var icon: String {
            switch self {
            case .selectedNone:
                return "plus"
            case .selectedOne:
                return "chevron.right"
            case .selectedMoreThanOne:
                return "exclamationmark.triangle.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .selectedNone:
                return .blue
            case .selectedOne:
                return .blue
            case .selectedMoreThanOne:
                return .red
            }
        }
        
    }
    
    var body: some View {
        
        HStack {
            AppIcon(icon: appConfig.appIcon, size: 30)
            TextModifier(text: appConfig.appName, fontConfig: .textStyle(style: .headline, weight:
                    .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
            Spacer()
            
            Button(action: {
                switch state {
                    
                case .selectedNone:
                    self.openPicker = true
                case .selectedOne:
                    self.openPicker = true
                case .selectedMoreThanOne:
                    self.openPicker = true
                }
            }, label: {
                HStack {
                    Text(state.rawValue)
                        .font(.system(.subheadline, weight: .medium))
                        .foregroundColor(state.color)
                    SFSymbol(iconName: state.icon, size: .subheadline, weight: .medium, fgColor: state.color, renderingMode: .monochrome)
                }
            })
            
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial.opacity(0.5))
        }
        .familyActivityPicker(headerText: "Only select Social < Instagram", isPresented: $openPicker, selection: $selection)
        .onChange(of: state) { state in
            if state == .selectedOne {
                print("Addig Token to Config")
                
                if let token = selection.applicationTokens.first?.hashValue {
                    addTokenAction(AppConfig(id: token, appName: appConfig.appName, appIcon: appConfig.appIcon, familyActivitySelection: selection))
                }
              
            }
        }
    }
}

struct AddAppCell_Previews: PreviewProvider {
    static var previews: some View {
        AddAppCell(appConfig: AppConfig(id: 0, appName: "Instagram", appIcon: instagram, familyActivitySelection: FamilyActivitySelection()), addTokenAction: { _ in})
    }
}
