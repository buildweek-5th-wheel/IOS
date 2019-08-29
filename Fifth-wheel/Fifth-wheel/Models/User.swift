//
//  User.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class User: Codable {
    var id: ReturnedId?
    let username: String
    var password: String
    var landowner: Bool?
    var imageURL: String?
    var bio: String?
    var token: Bearer?
    var listings: [Listing]?
    var bookings: [Booking]?
    
    init(username: String, password: String, landowner: Bool? = false) {
        self.username = username
        self.password = password
        self.landowner = landowner
    }
}

struct Bearer: Codable {
    var token: String
}
