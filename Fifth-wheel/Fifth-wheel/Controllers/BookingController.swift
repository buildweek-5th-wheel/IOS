//
//  BookingController.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation


class BookingController {
    
    //Properties
    var userBookings: [Booking] = []
}

//MARK: - CRUD
extension BookingController {
    
    func createBooking(listing: Listing, user:User, startDate: Date, endDate: Date) {
        guard let listingId = listing.listingId,
            let userId = user.id
            else {
                return print("No listing/user ID")
        }
        let newBooking = Booking(listingId: listingId.listingId!, userId: userId.id!, startDate: startDate, endDate: endDate, listedBy: user.username)
        //New Booking Network Call
        userBookings.append(newBooking)
    }
    func deleteListing(booking: Booking) {
        //deleteNetworkListing(listing: listing)
        guard let index = userBookings.firstIndex(of: booking) else {return}
        userBookings.remove(at: index)
    }
}


