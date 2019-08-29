//
//  LoginViewController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/25/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let userController = UserController()

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLabel.text = "Sign Up"
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        buttonLabel.text = "Sign Up"
        usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        buttonLabel.text = "Sign In"
        usernameTextField.becomeFirstResponder()
    }

    
    @IBAction func goButtonTapped(_ sender: Any) {
        print (buttonLabel.text ?? "N/A")
        guard let username = usernameTextField.text,
                let password = passwordTextField.text else {return}
        let user = User(username: username, password: password)
        
        
        switch buttonLabel.text {
        case "Sign In":
            userController.signIn(with: user) { (error) in
                if let error = error {
                    NSLog("Error signing in: \(error)")
                    //Alert Message login failed
                    let alert = UIAlertController(title: "Login", message: "Login failed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.userController.loggedInUser = user
                    self.performSegue(withIdentifier: "TabBarSegue", sender: self)
                }
            }
        case "Sign Up":
            registerUserAskIfLandowner(user: user)
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
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any?) -> Bool {
        if withIdentifier == "TabBarSegue" {
            guard let _ = userController.loggedInUser else {return false}
            return true
        }
        return true
    }

    func registerUserAskIfLandowner (user: User) {
        let alert = UIAlertController(title: "LandOwner", message: "Are you a landowner wanting to post listings?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [alert] (_) in
            callRegisterUser(user: user, landowner: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: {[alert] (_) in
            callRegisterUser(user: user, landowner: false)
        }))
        self.present(alert, animated: true, completion: nil)
        
        func callRegisterUser(user: User, landowner: Bool) {
            let user = user
            user.landowner = landowner
            userController.signUp(with: user) { (error) in
                if let error = error {
                    NSLog("Error signing up: \(error)")
                    //add code here if there was an error returned by the database
                    //Alert Message registration failed
                    let alert = UIAlertController(title: "Registration", message: "Registration failed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "TabBarSegue", sender: self)
                }
                
            }
        }
    }
}


