//
//  ListingBookDetailViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//
import Foundation
import UIKit

class ListingBookDetailViewController: UIViewController {
    var listingController: ListingController?
    var userController: UserController?
    var delegate: ListingManagerDelegate?
    
    
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViews()
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateViews()
//        // Do any additional setup after loading the view.
//    }
    
    func updateViews() {
        if let listing = listing {
            if let imageURL = listing.imageUrl {
                imageView.downloaded(from: imageURL)
            } else {
                imageView.image = UIImage(named: "GenericCamping")
            }
            checkInDateLabel.text = String(describing: checkInDate)
            checkOutDateLabel.text = String(describing: checkOutDate)
            let name = listing.listingName
            navigationController?.title = name
            descriptionTextView.text = listing.description
            locationLabel.text = listing.address
            //TODO: Do listing user name lookup and display
        }
    }
    
    @IBAction func bookTapped(_ sender: Any) {
        //TODO: write code to book listing, return success or failure, seque back
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
