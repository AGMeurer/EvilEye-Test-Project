//
//  PrimaryButtonLabel.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

import SwiftUI

struct PrimaryButtonLabel: View {
    
    let buttonText: String
    
    var buttonState: ButtonState
    
    var isProgressing: Bool
    
    var body: some View {
        HStack {
            if !isProgressing {
                Spacer()
            }
            
            if isProgressing {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.3)
            } else {
                Text(buttonText)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            
            if !isProgressing {
                Spacer()
            }
        }
        .padding()
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: isProgressing ? 50 : 15)
                    .fill(.blue)
                
                if isProgressing {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.primary)
                }
            }
        }
        .animation(.easeIn, value: isProgressing)
        .opacity(buttonState == .isEligible ? 1 : 0.5)
        .padding(.horizontal, 30)
    }
}

struct PrimaryButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonLabel(buttonText: "Continue", buttonState: .isEligible, isProgressing: true)
    }
}
