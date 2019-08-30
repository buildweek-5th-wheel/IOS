//
//  AccountViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    //Properties
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if token == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            return
        }
    }

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var landownerSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        let landowner = landownerSwitch.isOn
        //TODO: Call API Update user, if successful, refresh screen
    }

    func updateViews() {
        usernameLabel.text = loggedInUser?.username
        //landownerSwitch.isOn = loggedInUser?.landowner
    }

    /*
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
