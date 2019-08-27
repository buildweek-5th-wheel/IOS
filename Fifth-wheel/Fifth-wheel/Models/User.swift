//
//  User.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: String?
    let username: String
    var password: String
    var landowner: Bool
    var imageURL: String?
    var bio: String?
    var token: Bearer?
    
    init(username: String, password: String, landowner: Bool) {
        self.username = username
        self.password = password
        self.landowner = landowner
    }
}

struct Bearer: Codable {
    var token: String
}
