//
//  ListingCollectionViewCell.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var listing: Listing? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        if let imageURL = listing?.imageURL {
            imageView.downloaded(from: imageURL)
        } else {
            imageView.image = UIImage(named: "GenericCamping")
        }
        let name = listing?.name
        nameLabel.text = name
        let description = listing?.description
        descriptionLabel.text = description
    }
    
}
