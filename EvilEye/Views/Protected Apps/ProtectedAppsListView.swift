//
//  ProtectedAppsListView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/14/23.
//

import SwiftUI

struct ProtectedAppsListView: View {
    
    @ObservedObject var protectionVM = ProtectionVM.shared
    
    var body: some View {
        NavigationSceleton(navigationBarTitle: "Protected Apps", subTitle: "A list of all applications you protect", navbarDisplayMode: .large, contentWrapper: .scrollView, navType: .navigationView) {
            List()
        } bottomContent: {
            
        } navbarLargeContent: {
            
        } navbarLeading: {
            
        } navbarCenter: {
            Logo(size: 45)
        } navbarTrailing: {
            
        }
        .task {
          await protectionVM.loadAllProtectedApps()
        }
    }
    
    @ViewBuilder
    func List()-> some View {
        if protectionVM.loadingAllProtectedAppsProcess == .isProcessing {
            ProgressView()
                .padding(.top)
        } else if protectionVM.protectedApps.isEmpty {
            NoProtectedApps()
        } else {
            LazyVStack(spacing: 15) {
                ForEach(protectionVM.protectedApps, id: \.id) { app in
                    ListCell(app)
                }
            }
            .padding(.top)
        }
    }
    
    @ViewBuilder
    func ListCell(_ protectedApp: ProtectedApp)-> some View {
        HStack(spacing: 15) {
            if let icon = protectedApp.appIcon {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            
            TextModifier(text: protectedApp.appName, fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
            
            Spacer()
            
            SFSymbolWithButtonAction(iconName: "xmark", size: .headline, weight: .semibold, fgColor: .secondary, renderingMode: .hierarchical) {
                
                withAnimation {
                    protectionVM.defaults.removeObject(forKey: "Protected_Apps_\(protectedApp.id)")
                    protectionVM.protectedApps.removeAll(where: { $0.id == protectedApp.id})
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func NoProtectedApps()-> some View {
        VStack {
            Image("Shortcuts")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
            
            TextModifier(text: "Start protecting your first application", fontConfig: .textStyle(style: .title, weight: .regular, design: .rounded), fgColor: .secondary, alignment: .center, lineLimit: 5)
                .padding(.horizontal, 120)
        }
        .padding(.top, 50)

    }
}

struct ProtectedAppsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProtectedAppsListView()
            .environmentObject(ProtectionVM())
    }
}
