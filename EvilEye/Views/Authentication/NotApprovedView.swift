//
//  NotApprovedView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct NotApprovedView: View {
    
    @EnvironmentObject var familyControlsVM: FamilyControlsVM
    
    var body: some View {
        
        NavigationSceleton(navigationBarTitle: "Approve Access", subTitle: "In order to continue, please approve Screen Time access", navbarDisplayMode: .large, contentWrapper: .scrollView, navType: .navigationView) {
            
            ///- Note: Content
            VStack(alignment: .leading, spacing: 35) {

                IconAndText(icon: "chart.bar.xaxis",headline: "Personalized Insights", text: "Tailored feedback on your device usage, highlighting patterns and suggesting breaks when it may be beneficial.")
                
                IconAndText(icon: "brain.head.profile",headline: "Improved Well-being", text: "Understanding how and when you use your device helps us provide recommendations for a healthier digital lifestyle, including potential periods for digital detox.")
                
                IconAndText(icon: "hourglass",headline: "Enhanced Features", text: "Our features rely on Screen Time data to function optimally and offer you a more personalized experience.")
                
                IconAndText(icon: "lock.fill",headline: "Data Privacy", text: "We deeply respect your privacy. Screen Time data is processed locally on your device, and we don't store or share this data with third parties. You always remain in control and can revoke access at any time.")
                
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 30)
            
        } bottomContent: {
            
            VStack {
                if familyControlsVM.userDidNotAllow {
                    VStack {
                        HStack {
                            Spacer()
                            SFSymbol(iconName: "exclamationmark.triangle.fill", size: .largeTitle, weight: .semibold, fgColor: .red, renderingMode: .hierarchical)
                            TextModifier(text: "Please accept access to continue", fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: .red, alignment: .center, lineLimit: 2)
                            Spacer()
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                                .padding(.horizontal, 30)
                        }
                    }
                    .transition(.move(edge: .bottom))
                }
                
                Button(action: {
                    familyControlsVM.triggerAuthRequest = true
                    smallVibration()
                    
                }, label: {
                    PrimaryButtonLabel(buttonText: "Approve", buttonState: .isEligible, isProgressing: false)
                })
            }
           
        } navbarLargeContent: {
            
        } navbarLeading: {
            
        } navbarCenter: {
            
            Logo(size: 40)
            
        } navbarTrailing: {
            
        }
        .onChange(of: familyControlsVM.triggerAuthRequest, perform: { newValue in
            if newValue {
                Task { await familyControlsVM.requestFamilyControlAuthorization(initial: false) }

                self.familyControlsVM.triggerAuthRequest = false
            }
        })
    }
    
    @ViewBuilder
    func IconAndText(icon: String, headline: String, text: String)-> some View {
        HStack(alignment: .top) {
           
            SFSymbol(iconName: icon, size: .title2, weight: .medium, fgColor: .blue, renderingMode: .hierarchical)
            
            VStack(alignment: .leading, spacing: 5) {
                TextModifier(text: headline, fontConfig: .textStyle(style: .headline, weight: .semibold, design: .default), fgColor: Color(uiColor: .systemBlue), alignment: .leading, lineLimit: 1)
                
                TextModifier(text: text,
                             fontConfig: .textStyle(style: .footnote, weight: .regular, design: .default),
                             fgColor: .secondary,
                             alignment: .leading,
                             lineLimit: 10)
            }
            Spacer()
        }
    }
 
}

struct NotApprovedView_Previews: PreviewProvider {
    static var previews: some View {
        NotApprovedView()
            .environmentObject(FamilyControlsVM())
    }
}
