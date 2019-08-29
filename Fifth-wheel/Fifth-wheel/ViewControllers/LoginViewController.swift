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
        //let user = User(username: username, password: password)
        /*
         committed out the above line becasue that is not the correct way to create a new user. A new user must be created through the createUser function so then that user can be referenced throughout the app.
         */
        userController.createUser(username: username, password: password, landowner: false)
        
        if buttonLabel.text == "Sign In" {
            userController.signIn(username: username, password: password, completion: { (error) in
                if let error = error {
                    NSLog("Error signing in: \(error)")
                    //Alert Message login failed
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sign In", message: "Sign In failed", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        } else {
            userController.signUp(username: username, password: password, landowner: false) { (error) in
                if let error = error {
                    NSLog("Error signing up: \(error)")
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sign Up", message: "Sign Up failed", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sign Up", message: "Successful", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
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
                guard let _ = userController.token else {return false}
                return true
            }
            return true
        }
    
//        func registerUserAskIfLandowner (user: User) {
//            let alert = UIAlertController(title: "LandOwner", message: "Are you a landowner wanting to post listings?", preferredStyle: .actionSheet)
//            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [alert] (_) in
//                callRegisterUser(user: user, landowner: true)
//            }))
//            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: {[alert] (_) in
//                callRegisterUser(user: user, landowner: false)
//            }))
//            self.present(alert, animated: true, completion: nil)
//
//            func callRegisterUser(user: User, landowner: Bool) {
//                let user = user
//                user.landowner = landowner
//                userController.signUp(with: user) { (error) in
//                    if let error = error {
//                        NSLog("Error signing up: \(error)")
//                        //add code here if there was an error returned by the database
//                        //Alert Message registration failed
//                        let alert = UIAlertController(title: "Registration", message: "Registration failed", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    } else {
//                        self.performSegue(withIdentifier: "TabBarSegue", sender: self)
//                    }
//
//                }
//            }
//        }
}


