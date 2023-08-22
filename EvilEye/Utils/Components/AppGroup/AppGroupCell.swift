//
//  AppGroup.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import SwiftUI
import FamilyControls
import ManagedSettings

enum AppGroupConfig {
    case list(appGroup: AppConfig)
    case row(appGroup: AppConfig)
}

struct AppGroupCell: View {
    
    let appGroupConfig: AppGroupConfig
    
    var body: some View {
        
        switch appGroupConfig {
        case .list(let appGroup):
            List(appGroup)
        case .row(let appGroup):
            Row(appGroup)
        }
    }
    
    @ViewBuilder
    func List(_ appGroup: AppConfig)-> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 3) {
                SFSymbol(iconName: "apps.iphone", size: .headline, weight: .semibold, fgColor: .primary, renderingMode: .hierarchical)
                TextModifier(text: "/50", fontConfig: .textStyle(style: .subheadline, weight: .medium, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
            }
            //            TextModifier(text: appGroup.selectionName, fontConfig: .textStyle(style: .title3, weight: .semibold, design: .rounded), fgColor: .blue, alignment: .leading, lineLimit: 2)
            //
            HStack {
                VStack(alignment: .leading) {
                    //                    ForEach(Array(appGroup.selection.applicationTokens), id: \.self) { token in
                    //                        Label(token)
                    //                            .font(.subheadline)
                    //                            .fontWeight(.medium)
                    //                    }
                    //
                    //                    ForEach(Array(appGroup.selection.categoryTokens), id: \.self) { token in
                    //                        Label(token)
                    //                            .font(.subheadline)
                    //                            .fontWeight(.medium)
                    //                    }
                    //
                    //                    ForEach(Array(appGroup.selection.webDomainTokens), id: \.self) { token in
                    //                        Label(token)
                    //                            .font(.subheadline)
                    //                            .fontWeight(.medium)
                    //                    }
                }
                Spacer()
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func Row(_ appGroup: AppConfig)-> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 3) {
                SFSymbol(iconName: "apps.iphone", size: .headline, weight: .semibold, fgColor: .primary, renderingMode: .hierarchical)
                TextModifier(text: "/50", fontConfig: .textStyle(style: .subheadline, weight: .medium, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
            }
            //            TextModifier(text: appGroup.selectionName, fontConfig: .textStyle(style: .headline, weight: .semibold, design: .rounded), fgColor: .blue, alignment: .leading, lineLimit: 2)
            
            HStack {
                VStack(alignment: .leading) {
                    //                    ForEach(Array(appGroup.selection.applicationTokens), id: \.self) { token in
                    //                        Label(token)
                    //                            .foregroundColor(.clear)
                    //                            .font(.footnote)
                    //                            .fontWeight(.medium)
                    //                    }
                    //
                    //                    ForEach(Array(appGroup.selection.categoryTokens), id: \.self) { token in
                    //                        Label(token)
                    //                            .foregroundColor(.clear)
                    //                            .font(.footnote)
                    //                            .fontWeight(.medium)
                    //                    }
                    //
                    //                    ForEach(Array(appGroup.selection.webDomainTokens), id: \.self) { token in
                    //                        Label(token)
                    //                            .foregroundColor(.clear)
                    //                            .font(.footnote)
                    //                            .fontWeight(.medium)
                    //                    }
                }
                Spacer()
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
            }
        }
        .padding(.horizontal)
        
    }
}

//struct AppGroupCell_Previews: PreviewProvider {
//    static var previews: some View {
//        AppGroupCell(appGroupConfig: .row(appGroup: AppConfig(id: "", selection: .applicationToken(token: ))))
//    }
//}
