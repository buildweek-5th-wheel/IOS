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
    let bookingController = BookingController()
    var delegate: ListingManagerDelegate?
    var datePicker: UIDatePicker?
    var datePicker2: UIDatePicker?
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var checkInTextField: UITextField!
    @IBOutlet weak var checkOutTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateViews()
        // Do any additional setup after loading the view.
        //let tap = UITapGestureRecognizer(target: self, action: #selector)
    }
    
    func updateViews() {
        if let listing = listing {
            if let imageURL = listing.imageUrl {
                imageView.downloaded(from: imageURL)
            } else {
                imageView.image = UIImage(named: "GenericCamping")
            }
//            checkInDateLabel.text = String(describing: checkInDate)
//            checkOutDateLabel.text = String(describing: checkOutDate)
            let name = listing.listingName
            navigationController?.title = name
            descriptionTextView.text = listing.description
            locationLabel.text = listing.address
            //TODO: Do listing user name lookup and display
            
            //DatePicker
            datePicker = UIDatePicker()
            datePicker?.datePickerMode = .date
            datePicker2 = UIDatePicker()
            datePicker2?.datePickerMode = .date
            let toolbar = UIToolbar()
            let toolbar2 = UIToolbar()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
            let doneButton2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker2))
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
            let cancelButton2 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            
            toolbar.sizeToFit()
            toolbar2.sizeToFit()
                toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
                toolbar2.setItems([doneButton2, spaceButton, cancelButton2], animated: false)
           
            checkInTextField.inputAccessoryView = toolbar
            checkOutTextField.inputAccessoryView = toolbar2
            checkInTextField.inputView = datePicker
            checkOutTextField.inputView = datePicker2
        }
    }
    @objc func doneDatePicker() {
        //For date format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        checkInTextField.text = formatter.string(from: datePicker!.date)
        checkInDate = formatter.string(from: datePicker!.date)
        self.view.endEditing(true)
    }
    @objc func doneDatePicker2() {
        //For date format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        checkOutTextField.text = formatter.string(from: datePicker2!.date)
        checkOutDate = formatter.string(from: datePicker2!.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    
    @IBAction func bookTapped(_ sender: Any) {
        
        guard let startDate = checkInDate,
              let endDate = checkOutDate else {return print("No Start Date And End Date")}
        let booking = BookingRequest()
        let newBooking = Booking(token: token!, startDate: startDate, endDate: endDate, listingId: listing!.listingId!)
        bookingController.postNetworkBooking(booking: newBooking, bookingRequest: booking) { (error) in
            if let error = error {
                NSLog("Error Booking Site: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Sign Up", message: "There was an error booking this listing. Please try again in a little bit.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "It's Booked!", message: "Gas up! You're all set to go!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.cancelButton.titleLabel?.text = "Exit"
                    self.cancelButton.tintColor = .blue
                }
            }
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
