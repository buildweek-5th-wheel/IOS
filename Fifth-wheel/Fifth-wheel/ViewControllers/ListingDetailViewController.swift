//
//  ListingDetailViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ListingDetailViewController: UIViewController {
    var listing: Listing?
    var delegate: ListingManagerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placenameLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if token == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let listing = listing {
            if let imageURL = listing.imageUrl {
                imageView.downloaded(from: imageURL)
            } else {
                imageView.image = UIImage(named: "GenericCamping")
            }
            let name = listing.listingName
            placenameLabel.text = name
            let description = listing.description
            locationLabel.text = description
            //TODO: Do listing user name lookup and display
        }
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
