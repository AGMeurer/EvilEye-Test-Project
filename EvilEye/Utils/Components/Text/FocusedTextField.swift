//
//  FocusedTextField.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/18/23.
//

import SwiftUI

struct FocusedTextField: View {
    
    @Binding var text: String
    let headline: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    /// - Keyboard State
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(headline)
                .font(.title3)
                .fontWeight(.semibold)
            
                TextField(placeholder, text: $text)
                    .foregroundColor(.blue)
                    .font(.title)
                    .fontWeight(.bold)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
                    .focused($isKeyboardShowing)
                    .multilineTextAlignment(.center)
                    
        }
        .padding(.horizontal)
       
        /// - Opening Keyboard When Tapped
        .onTapGesture {
            isKeyboardShowing.toggle()
        }
//        .onAppear {
//            self.isKeyboardShowing = true
//        }
    }
}

struct FocusedTextField_Previews: PreviewProvider {
    static var previews: some View {
        FocusedTextField(text: .constant(""), headline: "What is your first name?", placeholder: "Full Name", keyboardType: .default)
    }
}

