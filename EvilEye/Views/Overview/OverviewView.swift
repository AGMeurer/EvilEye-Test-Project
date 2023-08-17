//
//  OverviewView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

struct OverviewView: View {
    
    @StateObject var appsSelectionVM = AppsSelectionVM()

    @State private var showAppsList: Bool = false
    @State private var activitySelection = FamilyActivitySelection()
    
    var body: some View {
        NavigationSceleton(navigationBarTitle: "Overview", subTitle: "See what is going on", navbarDisplayMode: .large, contentWrapper: .noWrapper, navType: .navigationView) {
            ///- Note: Content
            
           SetupListView()

        } bottomContent: {
            ///- Note: Bottom Button
        } navbarLargeContent: {
            
        } navbarLeading: {
            
        } navbarCenter: {
            Logo(size: 30)
        } navbarTrailing: {
            
        }
        .familyActivityPicker(isPresented: $showAppsList, selection: $appsSelectionVM.selection)

    }
    
    private func SetupListView()-> some View {
        List {

            SetUpAppSelection()
        }
    }
    
    @ViewBuilder
    func SetUpAppSelection()-> some View {
        VStack(alignment: .leading) {
            
            Button(action: {
                self.showAppsList = true
            }, label: {
                HStack {
                    TextModifier(text: "Select Applications", fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: .primary, alignment: .leading, lineLimit: 1)
                    Spacer()
                    SFSymbol(iconName: "plus", size: .title3, weight: .bold, fgColor: .blue, renderingMode: .hierarchical)
                }
            })
            
            if appsSelectionVM.isSelectionEmpty() {
                Text("No Applications selected")
                    .foregroundColor(Color.secondary)
            } else {
                ForEach(Array(appsSelectionVM.selection.applicationTokens), id: \.self) { token in
                    Label(token)
                    
                }
                ForEach(Array(appsSelectionVM.selection.categoryTokens), id: \.self) { token in
                    Label(token)
                }
                ForEach(Array(appsSelectionVM.selection.webDomainTokens), id: \.self) { token in
                    Label(token)
                }
            }
            
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
