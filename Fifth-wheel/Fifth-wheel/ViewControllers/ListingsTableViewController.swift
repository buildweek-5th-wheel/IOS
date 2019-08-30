//
//  ListingsTableViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ListingCell"

class ListingsTableViewController: UITableViewController {
    
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listingController.allListings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ListingTableViewCell else { return UITableViewCell()}
        cell.listing = listingController.allListings[indexPath.item]
        return cell
    }
    

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        guard let vc = segue.destination as? ListingDetailViewController else { return }
//        switch segue.identifier {
//        case "AddListing":
//            vc.delegate = self
//        case "DetailListing":
//            if let indexPath = tableView.indexPathForSelectedRow {
//                vc.listing = listingController.allListings[indexPath.item]
//                vc.delegate = self
//            }
//        default:
//            break
//        }
//    }
//
}

extension ListingsTableViewController: ListingManagerDelegate {
    func addListing(listing: Listing) {
        
    }
    
    func updateListing(listing: Listing) {
        
    }
    
    
}
