//
//  SetDatesViewController.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class SetDatesViewController: UIViewController {
    //Properties
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func dateSetButton(_ sender: Any) {
        checkInDate = checkInDatePicker.date
        checkOutDate = checkOutDatePicker.date
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
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
