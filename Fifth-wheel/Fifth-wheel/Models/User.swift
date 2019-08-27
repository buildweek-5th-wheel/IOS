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
    var id:         UInt? = nil
    var authToken:  String? = nil
    let username:   String
    let password:   String
    var landowner:  Bool = false
    var imageURL:   String? = nil
    var bio:        String? = nil
    
    init (username: String, password: String, landowner: Bool = false) {
        self.username = username
        self.password = password
        self.landowner = landowner
    }
    
    mutating func toggleLandowner() {
        self.landowner = !landowner
    }
}
