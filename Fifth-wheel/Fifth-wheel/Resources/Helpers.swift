//
//  Helpers.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation
//Global Controllers
let userController = UserController()
let listingController = ListingController()

struct ReturnedId: Codable, Equatable {
    let listingId: Int?
    let userId: Int?
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
