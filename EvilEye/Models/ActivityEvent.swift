//
//  AppGroup.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/17/23.
//

import Foundation
import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

struct ActivityEvent: Codable {
    var activityName: String
    var appGroup: AppConfig
    var day: Date
    var startTime: Date
    var endTime: Date
}

//struct AppGroup: Identifiable, Codable, Hashable {
//    var id = UUID().uuidString
//    var title: String
//    var selection: FamilyActivitySelection
//}
