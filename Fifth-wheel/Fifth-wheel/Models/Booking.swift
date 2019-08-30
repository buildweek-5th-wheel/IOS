//
//  Booking.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation
//CodingKey


class Booking: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case listingId = "listing_id"
        case userId = "user_id"
        case listedBy
        case startDate
        case stopDate
        
    }
    
    var token: Bearer?
    var bookingId: Int?
    var listingId: Int?
    var userId: Int?
    var listedBy: String?
    var startDate: String
    var stopDate: String
    
    init(token: Bearer, startDate: String, endDate: String, listingId: Int) {
        self.token = token
        self.listingId = listingId
        self.startDate = startDate
        self.stopDate = endDate
    }
}
    
    class BookingRequest: Codable {
        let startDate: String
        let stopDate: String
        
        init(startDate: String = checkInDate!, stopDate: String = checkOutDate!) {
            self.startDate = startDate
            self.stopDate = stopDate
        
    }
}

//Protocol
extension Booking {
    static func == (lhs: Booking, rhs: Booking) -> Bool {
        return lhs.bookingId == rhs.bookingId
    }
}
