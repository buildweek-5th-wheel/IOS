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
    var userListings: [Listing] = []
    var allListings: [Listing] = []
    
    func getListingImageUrl (byId listingId: Int) -> String {
        var result: String = ""
        for listing in self.allListings {
            if let id = listing.listingId {
                if id == listingId {
                    if let imageUrl = listing.imageUrl {
                        result = imageUrl
                    }
                }
            }
        }
        return result
    }
    
    func getListing (withId listingId: Int) -> Listing? {
        for listing in self.allListings {
            if let id = listing.listingId {
                if id == listingId {
                    return listing
                }
            }
        }
        return nil
    }
}

//MARK: - CRUD
extension ListingController {
    
    func createListing(tokenID: Int, listingName: String, description: String) {
        //let id = userID
        let newListing = Listing(userId: tokenID, listingName: listingName, description: description)
        postNetworkListing(listing: newListing, tokenID: tokenID)
        userListings.append(newListing)
    }
    
    func updateListing(listing: Listing, listingName: String, description: String, image: String?) {
        listing.description = description
        listing.listingName = listingName
        listing.imageUrl = image
        updateNetworkListing(listing: listing)
    }
    
    func deleteListing(listing: Listing) {
        deleteNetworkListing(listing: listing)
        guard let index = userListings.firstIndex(of: listing) else {return}
        userListings.remove(at: index)
    }
}

//MARK: - Network Functions
extension ListingController {
    
    func postNetworkListing (listing: Listing, tokenID: Int, completion: @escaping (NetworkError?) -> Void = { _ in}) {
        guard let token = token?.token else {
            completion(.badAuth)
            return
        }
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let postListingURL = baseURL.appendingPathComponent("listings")
        var request = URLRequest(url: postListingURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        do {
            request.httpBody = try encoder.encode(listing)
        } catch {
            NSLog("ListingController: postNetworkListing error: \(error)")
            completion(.noEncode)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
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
            completion(nil)
            }.resume()
    }
    
    func getAllNetworkListings(completion: @escaping (NetworkError?) -> Void = { _ in})  {
        
        let allListingUrl = baseURL.appendingPathComponent("listings")
        var request = URLRequest(url: allListingUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.otherError(NSError()))
                return
            }
            if let error = error {
                completion(.otherError(error))
                return
            }
            guard let data = data else {
                completion(.noData)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.allListings = try decoder.decode([Listing].self, from: data)
                completion(nil)
            } catch {
                completion(.otherError(error))
                return
            }
            completion(nil)
            }.resume()
    }
    
    func deleteNetworkListing(listing: Listing, completion: @escaping (NetworkError?) -> Void = { _ in}) {
        guard let token = token?.token else {
            completion(.badAuth)
            return
        }
        let deleteUrl = baseURL.appendingPathComponent("listings").appendingPathComponent(String(describing: listing.listingId))
        var request = URLRequest(url: deleteUrl)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                NSLog("Error deleting Listing")
                completion(.failedDelete(error))
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failedDelete(NSError()))
                return
            }
            completion(nil)
            }.resume()
    }
    
    func updateNetworkListing(listing: Listing, completion: @escaping (NetworkError?) -> Void = { _ in}) {
        guard let token = token?.token else {
            completion(.badAuth)
            return
        }
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let updateURl = baseURL.appendingPathComponent("listings").appendingPathComponent(String(describing: listing.listingId))
        var request = URLRequest(url: updateURl)
        request.httpMethod = HTTPMethod.put.rawValue
        request.addValue("\(token)", forHTTPHeaderField: "token")
        do {
            let data = try encoder.encode(listing)
            request.httpBody = data
        } catch {
            NSLog("ListingController: Error encoding updated listing: \(error)")
            completion(.noEncode)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                NSLog("ListingController: Error updating listing: \(error)")
                completion(.noUpdate(error))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Network returned wrong code")
                completion(.noUpdate(NSError()))
                return
            }
            completion(nil)
        }.resume()
    }
}

protocol ListingManagerDelegate {
    func addListing(listing: Listing)
    func updateListing(listing: Listing)
}
