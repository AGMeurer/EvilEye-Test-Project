//
//  Constants.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import SwiftUI

func smallVibration() {
    let impactLight = UIImpactFeedbackGenerator(style: .soft)
    impactLight.impactOccurred()
}
