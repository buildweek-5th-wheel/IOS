//
//  Helpers.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation
//Global Properties
let userController = UserController()
let listingController = ListingController()
var token: Bearer?
var loggedInUser: LogginUser?
var listing: Listing?
var checkInDate: String?
var checkOutDate: String?
var bookingRequest = BookingRequest()

struct ReturnedId: Codable, Equatable {
    let listingId: Int?
    let id: Int?
    
    static func == (lhs: ReturnedId, rhs: ReturnedId) -> Bool {
        return lhs.listingId == rhs.listingId &&
               lhs.id == rhs.id
    }
}


//Errors
enum NetworkError: Error {
    case noData
    case badAuth
    case noDecode
    case failedFetch(Error)
    case badURL
    case invalidData
    case failedSignUp(Error)
    case otherError(Error)
    case noEncode
    case noIDReturned
    case failedPost(Error)
    case failedDelete(Error)
    case noUpdate(Error)
}
enum AppError: Error {
    case noData
    case badAuth
    case noDecode
    case failedFetch(Error)
    case badURL
    case invalidData
    case failedSignUp
}

//Network
let baseURL = URL(string: "https://bw-5th-wheel.herokuapp.com")!
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "Delete"
    case put = "PUT"
}
