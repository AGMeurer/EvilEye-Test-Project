//
//  AppProtectionView.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/14/23.
//

import SwiftUI

struct AppProtectionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let appToProtect: ProtectedApp?
    
    ///- Note: Timer Properties
    @State private var timerValue: Double = 5
    @State private var isTimerCompleted: Bool = false
    @State private var timer: Timer? = nil
    
    ///- Note: Body
    var body: some View {
        NavigationSceleton(navigationBarTitle: "", subTitle: "", navbarDisplayMode: .inline, contentWrapper: .noWrapper, navType: .navigationView) {
            
            VStack {
                Spacer()
                if let app = appToProtect {
                    MainContent(app: app)
                } else {
                    Placeholder()
                }
                Spacer()
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
            
        } bottomContent: {
            if let app = appToProtect {
                BottomContent(app: app)
                    .padding(.bottom)
            }
        } navbarLargeContent: {
            
        } navbarLeading: {
            
        } navbarCenter: {
            Logo(size: 40)
        } navbarTrailing: {
            
        }
//        .onAppear {
//            ProtectFromAppIntent.openAppWhenRun = false
//        }

    }
    
    ///- Note: Main Content
    @ViewBuilder
    func MainContent(app: ProtectedApp)-> some View {
        VStack(spacing: 30) {
            Text(app.appName)
                .font(.system(.largeTitle, weight: .bold))
        }
    }
    
    @ViewBuilder
    func BottomContent(app: ProtectedApp)-> some View {
        if !isTimerCompleted {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.blue.gradient)
                .frame(width: (UIScreen.main.bounds.width - 40) * (timerValue / 5), height: 10)
            
        } else {
            VStack {
                TextModifier(text: "You choose", fontConfig: .textStyle(style: .title2, weight: .bold, design: .default), fgColor: .primary, alignment: .center, lineLimit: 1)
                    .padding(.bottom, 5)
                
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    }
                }, label: {
                    PrimaryButtonLabel(buttonText: "Close", buttonState: .isEligible, isProgressing: false)
                })
                
                Button(action: {
                    //- OpenAppWhenRun must be false when this button is pressed
                    if let appID = appToProtect?.id {
                        if let url = URL(string: "\(appID)://") {
                            UIApplication.shared.open(url)
                        }
                    }
                }, label: {
                    
                    TextModifier(text: "Go back to \(appToProtect?.appName ?? "App not found")", fontConfig: .textStyle(style: .subheadline, weight: .medium, design: .default), fgColor: .primary, alignment: .center, lineLimit: 2)
                })
            }
        }
    }
    
    ///- Note: Placeholder
    @ViewBuilder
    func Placeholder()-> some View {
        Text("Could not find protected App")
            .padding()
            .font(.headline)
    }
    
    ///- Note: Function to display the timer
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if timerValue > 0 {
                withAnimation(.linear(duration: 0.01)) {
                    timerValue -= Double(0.01)
                }
            } else {
                timer?.invalidate()
                withAnimation {
                    isTimerCompleted = true
                }
            }
        }
    }
}

struct AppProtectionView_Previews: PreviewProvider {
    static var previews: some View {
        AppProtectionView(appToProtect: ProtectedApp(id: "", appName: "Instagram", appIcon: ""))
    }
}
