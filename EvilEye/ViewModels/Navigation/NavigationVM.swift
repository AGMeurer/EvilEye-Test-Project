//
//  NavigationVM.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import SwiftUI

class NavigationVM: ObservableObject {
    @Published var selectedTab: Int = 0
}
