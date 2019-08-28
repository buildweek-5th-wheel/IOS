//
//  ListingTableViewCell.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    var listing: Listing?{
        didSet{
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateViews() {
        titleLabel.text = listing?.name
        subtitleLabel.text = listing?.description
    }
}
