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
    
    func createListing(userID: ReturnedId, listingName: String, description: String) {
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

//MARK: - Network Functions
extension ListingController {
    
    func postNetworkListing (listing: Listing, userID: Int, completion: @escaping (NetworkError?) -> Void = { _ in}) {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestURL = baseURL.appendingPathComponent("listings").appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try encoder.encode(listing)
        } catch {
            NSLog("ListingController: postNetworkListing error: \(error)")
            completion(.noEncode)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                completion(NetworkError.failedPost(NSError(domain: baseURL.absoluteString, code: response.statusCode, userInfo: nil)))
                return
            }
            
            if let error = error {
                NSLog("ListingController: postNetworkingListing error: \(error)")
                completion(.noEncode)
                return
            }
            guard let data = data else {completion(NetworkError.invalidData); return}
            
            do {
                listing.listingId = try decoder.decode(ReturnedId.self, from: data)
            } catch {
                NSLog("ListingController: Error adding listingID: \(error)")
                completion(NetworkError.noIDReturned)
                return
            }
            completion(nil)
        }.resume()
    }
}
