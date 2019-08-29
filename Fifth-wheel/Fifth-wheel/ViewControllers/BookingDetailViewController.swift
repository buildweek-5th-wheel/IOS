//
//  BookingDetailViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class BookingDetailViewController: UIViewController {
    
    var booking: Booking?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel! //TODO:  Why this label?
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let booking = booking else { return }
        let listing = listingController.getListing (withId: booking.listingId)
        if let imageUrl = listing?.imageUrl {
            imageView.downloaded(from:  imageUrl)
        }
        if let location = listing?.listingName {
            locationLabel.text = location
        }
        hostLabel.text = booking.listedBy
        dateLabel.text = "\(booking.startDate) - \(booking.endDate)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
