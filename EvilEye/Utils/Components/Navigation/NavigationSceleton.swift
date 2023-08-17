//
//  NavigationSceleton.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

enum ContentWrapper {
    case scrollView
    case list
    case noWrapper
}

enum NavigationType {
    case navigationStack
    case navigationView
}

struct NavigationSceleton<Content: View, BottomContent: View, NavbarLargeContent: View, NavbarLeading: View, NavbarCenter: View, NavbarTrailing: View>: View {
    
    let navigationBarTitle: String
    let subTitle: String
    let navbarDisplayMode: NavigationBarItem.TitleDisplayMode
    let contentWrapper: ContentWrapper
    let navType: NavigationType
    let content: Content
    let bottomContent: BottomContent
    let navbarLargeContent: NavbarLargeContent
    let navbarLeading: NavbarLeading
    let navbarCenter: NavbarCenter
    let navbarTrailing: NavbarTrailing
    
    init(navigationBarTitle: String, subTitle: String, navbarDisplayMode: NavigationBarItem.TitleDisplayMode, contentWrapper: ContentWrapper, navType: NavigationType, @ViewBuilder content: () -> Content, @ViewBuilder bottomContent: () -> BottomContent, @ViewBuilder navbarLargeContent: () -> NavbarLargeContent, @ViewBuilder navbarLeading: () -> NavbarLeading, @ViewBuilder navbarCenter: () -> NavbarCenter, @ViewBuilder navbarTrailing: () -> NavbarTrailing) {
        
        self.navigationBarTitle = navigationBarTitle
        self.subTitle = subTitle
        self.navbarDisplayMode = navbarDisplayMode
        self.contentWrapper = contentWrapper
        self.navType = navType
        self.content = content()
        self.navbarLargeContent = navbarLargeContent()
        self.bottomContent = bottomContent()
        self.navbarLeading = navbarLeading()
        self.navbarCenter = navbarCenter()
        self.navbarTrailing = navbarTrailing()
    }
    
    
    var body: some View {
        switch navType {
        case .navigationStack:
            NavigationStack {
                ContentSection()
            }
        case .navigationView:
            NavigationView {
                ContentSection()
            }
        }
        
    }
    
    @ViewBuilder
    func ContentSection()-> some View {
        ZStack(alignment: .bottom) {
            switch contentWrapper {
            case .scrollView:
                ScrollView {
                    HeaderExtra()
                    content
                }
            case .list:
                List {
                    content
                }
            case .noWrapper:
                content
            }
            
            ///- Note: Bottom Content
            bottomContent
        }
        .navigationBarTitleDisplayMode(navbarDisplayMode)
        .navigationTitle(navigationBarTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                navbarLeading
            }
            ToolbarItem(placement: .principal) {
               navbarCenter
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                navbarTrailing
            }
        }
    }
    
    @ViewBuilder
    func HeaderExtra()-> some View {
        HStack {
            Text(subTitle)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .offset(y: -8)
            
            Spacer()
            
            
        }
        .overlay(alignment: .topTrailing) {
            navbarLargeContent
                .zIndex(-100)
                .offset(y: -45)
        }
        .padding(.horizontal, 20)
    }
}

struct NavigationSceleton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSceleton(navigationBarTitle: "Register", subTitle: "Register to Drinksta", navbarDisplayMode: .large, contentWrapper: .list, navType: .navigationStack) {
            
            ForEach(0..<3) { _ in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 200)
            }
        } bottomContent: {
            
            PrimaryButtonLabel(buttonText: "Continue", buttonState: .isEligible, isProgressing: false)
            
        } navbarLargeContent: {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 50))
                
        } navbarLeading: {
            Image(systemName: "chevron.left")
        } navbarCenter: {
            
        } navbarTrailing: {
            Image(systemName: "chevron.right")
        }

    }
}
