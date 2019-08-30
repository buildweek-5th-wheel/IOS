//
//  DiscoverCollectionViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/27/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ListingCell"

class DiscoverCollectionViewController: UICollectionViewController {
    
    let userController = UserController()
    let listingController = ListingController()


    override func viewDidLoad() {
        super.viewDidLoad()
        userController.loadToken()
        userController.loadUsername()
        listingController.getAllNetworkListings { (error) in
            if let error = error {
                NSLog("Error getting listings: \(error)")
            } else  {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listingController.allListings.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ListingCollectionViewCell else {
            
            fatalError("check for typos")}
        cell.listing = listingController.allListings[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedListing = listingController.allListings[indexPath.row]
        listing = selectedListing
        //self.navigationController?.pushViewController(detailedVC, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListingCellSegue" {
            guard let detailedVC = segue.destination as? ListingBookDetailViewController else {return}
            detailedVC.listingController = listingController
            detailedVC.userController = userController
        }
    }

}
