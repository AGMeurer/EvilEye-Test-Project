//
//  Logo.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import SwiftUI

struct Logo: View {
    
    let size: CGFloat
    
    var body: some View {
        
        Image("Logo")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo(size: 100)
    }
}
