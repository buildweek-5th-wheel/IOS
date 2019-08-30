//
//  ListingCollectionViewCell.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//
import Foundation
import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var listing: Listing? {
        didSet{
                self.updateViews()
        }
    }

    
    
    func updateViews() {
        guard let imageURL = listing?.imageUrl else {return print("No Image url")}
        if imageURL != "" {
            imageView.downloaded(from: imageURL)
        } else {
            imageView.image = UIImage(named: "GenericCamping")
        }
        let name = listing?.listingName
        nameLabel.text = name
        let description = listing?.description
        descriptionLabel.text = description
    }
    
}
