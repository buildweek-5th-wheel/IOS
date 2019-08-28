//
//  Listing.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class Listing: Codable, Equatable {
    
    var listingId: Int?
    var userId: String
    var listingName: String
    var description: String
    var imageUrl: String?
    
    init(userId: String, listingName: String, description: String) {
        self.userId = userId
        self.listingName = listingName
        self.description = description
    }
    
    
}

//Protocols
extension Listing {
    static func == (lhs: Listing, rhs: Listing) -> Bool {
        return lhs.listingId == rhs.listingId &&
        lhs.description == rhs.description &&
        lhs.listingName == rhs.listingName &&
        lhs.imageUrl == rhs.imageUrl
        lhs.userId == rhs.userId
    }
}
