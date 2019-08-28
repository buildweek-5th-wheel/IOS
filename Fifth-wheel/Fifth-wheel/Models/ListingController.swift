//
//  ListingController.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class ListingController {
    
    //Properties
    var userConroller: UserController?
    var userListings: [Listing] = []
    var allListings: [Listing] = []
}

//MARK: - CRUD
extension ListingController {
    
    func createListing(userID: String, listingName: String, description: String) {
        let newListing = Listing(userId: userID, listingName: listingName, description: description)
        //network put function
        userListings.append(newListing)
    }
    
    func updateListing(listing: Listing, listingName: String, description: String, image: String?) {
        //network update function
        listing.description = description
        listing.listingName = listingName
        listing.imageUrl = image
    }
    
    func deleteListing(listing: Listing) {
        //network delete function
        guard let index = userListings.firstIndex(of: listing) else {return}
        userListings.remove(at: index)
    }
}
