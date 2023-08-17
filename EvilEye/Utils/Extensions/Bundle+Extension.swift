//
//  Bundle+Extension.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/17/23.
//

import Foundation

extension Bundle {
   
    var APP_GROUP_NAME: String {
        guard let value = Bundle.main.infoDictionary?["APP_GROUP_NAME"] as? String else {
            fatalError("APP_NAME not set in Info.plist")
        }
        
        print("APP_GROUP_NAME = \(value)")
        return value
    }
}
