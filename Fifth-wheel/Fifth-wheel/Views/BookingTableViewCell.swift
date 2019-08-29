//
//  BookingTableViewCell.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    
    var booking: Booking? {
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateViews() {
        guard let listedBy = booking?.listedBy,
            let startDate = booking?.startDate,
            let endDate = booking?.endDate else {
                titleLabel.text = "Error"
                return
        }
        let text = "\(listedBy) - \(startDate) - \(endDate)"
        titleLabel.text = text
    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
