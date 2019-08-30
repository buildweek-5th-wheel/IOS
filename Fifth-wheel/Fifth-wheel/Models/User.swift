//
//  User.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class User: Codable {
    let username: String
    var id: Int?
    var password: String?
    var landowner: Bool?
    var imageURL: String?
    var bio: String?
    var telephone: String?
    var email: String?
    var listings: [Listing]?
    var bookings: [Booking]?
    
    init(username: String, password: String, landowner: Bool?) {
        self.username = username
        self.password = password
        self.landowner = landowner
    }
}

struct Bearer: Codable {
    let token: String
    let id: Int
}

struct LogginUser: Codable {
    var username: String
}
