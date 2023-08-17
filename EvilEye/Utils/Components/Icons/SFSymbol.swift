//
//  SFSymbol.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct SFSymbol: View {
    
    let iconName: String
    let size: Font.TextStyle
    let weight: Font.Weight
    let fgColor: Color
    let renderingMode: SymbolRenderingMode
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size, weight: weight))
            .foregroundColor(fgColor)
            .symbolRenderingMode(renderingMode)
    }
}

struct SFSymbol_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbol(iconName: "chevron.left", size: .largeTitle, weight: .bold, fgColor: Color.primary, renderingMode: .hierarchical)
    }
}

struct SFSymbolWithButtonAction: View {
    
    let iconName: String
    let size: Font.TextStyle
    let weight: Font.Weight
    let fgColor: Color
    let renderingMode: SymbolRenderingMode
    let buttonAction: () -> Void
    
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            Image(systemName: iconName)
                .font(.system(size, weight: weight))
                .foregroundColor(fgColor)
                .symbolRenderingMode(renderingMode)
        })
        
    }
}
