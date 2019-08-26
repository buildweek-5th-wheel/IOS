//
//  Listing.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Listing: Codable {
    var listingId: Int?
    let userId: String
    var listingName: String
    var description: String
    var imageUrl: String?
    
    init(userId: String, listingName: String, description: String) {
        self.userId = userId
        self.listingName = listingName
        self.description = description
    }
}
