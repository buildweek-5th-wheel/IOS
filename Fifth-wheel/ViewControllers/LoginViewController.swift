//
//  LoginViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/25/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        buttonLabel.text = "Sign Up"
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        buttonLabel.text = "Sign In"
    }

    
    @IBAction func goButtonTapped(_ sender: Any) {
        switch buttonLabel.text {
        case "Sign In":
            guard let usernameText = usernameTextField.text, !usernameText.isEmpty,
                let passwordText = passwordTextField.text, !passwordText.isEmpty else {
                    return
            }
            let isLandower = askIfLandowner ()
            let user = User(username: usernameText, password: passwordText, landowner: isLandower)
            userController.loginUser(user: user)
            //Sart segue to Discover view
        case "Sign Up":
            break
        default:
            break
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    func askIfLandowner () -> Bool {
        var landOwner: Bool = false
        let alert = UIAlertController(title: "LandOwner", message: "Are you a landowner wanting to post listings?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak alert] (_) in
            landOwner = true
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { [weak alert] (_) in
            landOwner = false
        }))
        return landOwner
    }

}
