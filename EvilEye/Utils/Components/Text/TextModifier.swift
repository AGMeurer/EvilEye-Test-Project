//
//  TextModifier.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct TextModifier: View {
    
    let text: String
    let fontConfig: FontConfig
    let fgColor: Color
    let alignment: TextAlignment?
    let lineLimit: Int?
    
    var body: some View {
        
        switch fontConfig {
        case .textStyle(let style, let weight, let design):
            
            Text(text)
                .font(.system(style, design: design, weight: weight))
                .foregroundColor(fgColor)
                .multilineTextAlignment(alignment ?? .leading)
                .lineLimit(lineLimit ?? 10000)
            
        case .customSize(let size, let weight, let design):
            
            Text(text)
                .font(.system(size: size, weight: weight, design: design))
                .foregroundColor(fgColor)
                .multilineTextAlignment(alignment ?? .leading)
                .lineLimit(lineLimit ?? 10000)
        }
        
    }
}

struct TextModifier_Previews: PreviewProvider {
    static var previews: some View {
        TextModifier(text: "Text", fontConfig: .textStyle(style: .body, weight: .bold, design: .rounded), fgColor: .pink, alignment: .center, lineLimit: 30)
   
    }
}
