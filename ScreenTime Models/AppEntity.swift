//
//  AppEntity.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import Foundation

struct ApplicationEntity: Identifiable {
    var id: UUID
    var appName: String
    var appIconData: Data?
}

extension ApplicationEntity {
    static let allApplications: [ApplicationEntity] = [
        ApplicationEntity(id: UUID(), appName: "Instagram"),
        ApplicationEntity(id: UUID(), appName: "TikTok"),
        ApplicationEntity(id: UUID(), appName: "Twitter"),
        ApplicationEntity(id: UUID(), appName: "Snapchat")
    ]
}
