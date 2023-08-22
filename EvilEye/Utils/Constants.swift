//
//  Constants.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import SwiftUI

///- Note: UserDefaults Key for AppGroups
let key = "appGroups"

func smallVibration() {
    let impactLight = UIImpactFeedbackGenerator(style: .soft)
    impactLight.impactOccurred()
}

extension View{
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

enum Process: Equatable {
    case notProcessing
    case isProcessing
    case success
    case failed(String)

}
