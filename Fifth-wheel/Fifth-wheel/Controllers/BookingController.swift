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

//MARK: - Network Functions
extension BookingController {
    
    func postNetworkBooking (booking: Booking, completion: @escaping (NetworkError?) -> Void = { _ in}) {
        guard let token = userController.loggedInUser?.token else {
            completion(.badAuth)
            return
        }
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let postBookingURL = baseURL.appendingPathComponent("listings").appendingPathComponent(String(describing: booking.listingId)).appendingPathComponent("booking")
        var request = URLRequest(url: postBookingURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        do {
            request.httpBody = try encoder.encode(booking)
        } catch {
            NSLog("BookingController: postNetworkBooking error: \(error)")
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
                NSLog("BookingController: postNetworkingBooking error: \(error)")
                completion(.noEncode)
                return
            }
            guard let data = data else {completion(NetworkError.invalidData); return}
            
            do {
                booking.bookingId = try decoder.decode(ReturnedId, from: data)
            } catch {
                NSLog("ListingController: Error adding listingID: \(error)")
                completion(NetworkError.noIDReturned)
                return
            }
            completion(nil)
            }.resume()
    }
}
