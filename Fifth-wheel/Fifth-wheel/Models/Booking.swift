//
//  Booking.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Booking {
    let id: UUID
    let listing: Listing
    let bookingUser: User
    let startDate: Date
    let endDate: Date
    var isBooked: Bool
    
    init(id: UUID = UUID(), listing: Listing, booker: User, startDate: Date, endDate: Date, isBooked: Bool = false) {
        
        self.id = id
        self.listing = listing
        self.bookingUser = booker
        self.startDate = startDate
        self.endDate = endDate
        self.isBooked = isBooked
    }
}
