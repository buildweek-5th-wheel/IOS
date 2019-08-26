//
//  User.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

// MARK: - Constants & Variables

struct User: Codable {
    let id:         UInt
    let username:   String
    var landowner:  Bool
    var imageURL:   String
    var bio:        String
    
    mutating func toggleLandowner() {
        self.landowner = !self.landowner
    }
}
