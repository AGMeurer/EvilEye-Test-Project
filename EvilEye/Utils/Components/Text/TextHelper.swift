//
//  TextHelper.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import SwiftUI

///- Note: For TextModifier
enum FontConfig {
    case textStyle(style: Font.TextStyle, weight: Font.Weight, design: Font.Design)
    case customSize(size: CGFloat, weight: Font.Weight, design: Font.Design)
}
