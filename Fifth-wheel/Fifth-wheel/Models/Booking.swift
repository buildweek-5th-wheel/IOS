//
//  Booking.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class Booking: Codable, Equatable {
    
    
    var bookingId: ReturnedId?
    let listingId: Int
    let userId: Int
    let listedBy: String
    var startDate: Date
    var endDate: Date
    
    init(listingId: Int, userId: Int, startDate: Date, endDate: Date, listedBy: String) {
        
        self.listingId = listingId
        self.userId = userId
        self.startDate = startDate
        self.endDate = endDate
        self.listedBy = listedBy
    }
}

//Protocol
extension Booking {
    static func == (lhs: Booking, rhs: Booking) -> Bool {
        return lhs.bookingId == rhs.bookingId
    }
}
