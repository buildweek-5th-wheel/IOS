//
//  Listing.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Constants & Variables

struct Listing: Codable {
    let id:             UInt
    let name:           String
    let uiserID:        UInt
    var description:    String
    var imageURL:       String?
    var latitude:       Double?
    var longitude:      Double?
}
