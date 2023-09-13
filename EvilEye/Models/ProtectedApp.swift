//
//  ProtectedApp.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/13/23.
//

import Foundation
import SwiftUI

///- Note: All Apps that are being Protected
struct ProtectedApp: Identifiable, Codable {
    var id: UUID
    //- Basic Metadata
    var appName: String
    var appIcon: String?
    
    //- Fancy Metadata
    var openedCount: Int?
    
    enum CodingKeys: String, CodingKey{
        case id
        case appName
        case appIcon
        case openedCount
    }
}
