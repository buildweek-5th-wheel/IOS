//
//  LoginViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/25/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    
    @IBOutlet weak var segmentedButton: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInRegButton: UIButton!
    @IBOutlet weak var landOwnerStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landOwnerStack.isHidden = true

        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func signInOrRegButtonTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
           signInRegButton.titleLabel?.text = "Sign In"
            landOwnerStack.isHidden = true
        } else {
            signInRegButton.titleLabel?.text = "Sign Up"
            landOwnerStack.isHidden = false
        }
    }
    
    @IBAction func signInRegTapped(_ sender: Any) {
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
