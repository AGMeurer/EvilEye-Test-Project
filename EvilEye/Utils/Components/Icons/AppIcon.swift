//
//  AppIcon.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/22/23.
//

import SwiftUI

struct AppIcon: View {
    
    let icon: String?
    let size: CGFloat
    
    var body: some View {
        if let icon = icon {
            if icon != "" {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
                    .frame(width: size, height: size)
            }
        } else {
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
                .frame(width: size, height: size)
        }
    }
}

struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
        AppIcon(icon: nil, size: 50)
    }
}
