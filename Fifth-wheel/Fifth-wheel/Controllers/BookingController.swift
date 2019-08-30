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

//    func createBooking(listing: Listing, userID: Int, user: LogginUser, startDate: String, endDate: String) {
//        guard let listingId = listing.listingId else {return print("No listing/user ID")}
//        _ = Booking(listingId: listingId, userId: userID, startDate: startDate, endDate: endDate)
//    }
    func deleteBooking(booking: Booking, listing: Listing) {
        deleteNetworkBooking(booking: booking, listing: listing)
        guard let index = userBookings.firstIndex(of: booking) else {return}
        userBookings.remove(at: index)
    }
}

//MARK: - Network Functions
extension BookingController {

    func postNetworkBooking (booking: Booking, bookingRequest: BookingRequest, completion: @escaping (NetworkError?) -> Void = { _ in}) {
        guard let currentToken = token else {
            completion(.badAuth)
            return
        }
        let encoder = JSONEncoder()
//        let decoder = JSONDecoder()
        guard let listing = listing else {return}
        let listingIdString = String(listing.listingId!)
        let postBookingURL = baseURL.appendingPathComponent("listings").appendingPathComponent(listingIdString).appendingPathComponent("booking")
        print("URL it is sent to: \(postBookingURL)")
        print("\(bookingRequest)")
        print(currentToken)
        
        var request = URLRequest(url: postBookingURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("\(currentToken)", forHTTPHeaderField: "token")

        do {
            request.httpBody = try encoder.encode(bookingRequest)
        } catch {
            NSLog("BookingController: postNetworkBooking error encoding booking: \(error)")
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
                NSLog("BookingController: postNetworkingBooking error: \(error)")
                completion(.noEncode)
                return
            }
//            guard let data = data else {completion(NetworkError.invalidData); return}
//
//            do {
//                booking.bookingId = try decoder.decode(ReturnedId.self, from: data)
//            } catch {
//                NSLog("ListingController: Error adding listingID: \(error)")
//                completion(NetworkError.noIDReturned)
//                return
//            }
            completion(nil)
            }.resume()
    }

    func deleteNetworkBooking
        (booking: Booking, listing: Listing, completion: @escaping (NetworkError?) -> Void = { _ in}) {
        guard let token = token else {
            completion(.badAuth)
            return
        }
        let deleteUrl = baseURL.appendingPathComponent("listings").appendingPathComponent(String(describing: listing.listingId)).appendingPathComponent("booking").appendingPathComponent(String(describing: booking.bookingId))
        var request = URLRequest(url: deleteUrl)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue("\(token)", forHTTPHeaderField: "token")

        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                NSLog("Error deleting booking")
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
}
