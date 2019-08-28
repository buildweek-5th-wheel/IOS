//
//  ListingController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

// MARK: - Constants & Variables
var listingController = ListingController()

// MARK: - Object/Method definitions

class ListingController {
    var listings: [Listing] = []
    
    init () {
        
    }
}

protocol ListingManager {
    func addListing (listing: Listing)
    func updateListing (listing: Listing)
}
