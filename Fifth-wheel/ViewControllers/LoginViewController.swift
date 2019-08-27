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
        buttonLabel.text = "Sign Up"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        buttonLabel.text = "Sign Up"
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        buttonLabel.text = "Sign In"
    }

    
    @IBAction func goButtonTapped(_ sender: Any) {
        print (buttonLabel.text ?? "N/A")
        switch buttonLabel.text {
        case "Sign In":
            guard let usernameText = usernameTextField.text, !usernameText.isEmpty,
                let passwordText = passwordTextField.text, !passwordText.isEmpty else { return }
            let user = User(username: usernameText, password: passwordText)
            if !userController.loginUser(user: user) {
                //Alert Message login failed
                let alert = UIAlertController(title: "Login", message: "Login failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                performSegue(withIdentifier: "TabBarSegue", sender: self)
            }
        case "Sign Up":
            registerUser()
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
            guard let _ = userController.currentUser else {return false}
            return true
        }
        return true
    }

    func registerUser () {
        let alert = UIAlertController(title: "LandOwner", message: "Are you a landowner wanting to post listings?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [alert] (_) in
            let landOwner = true
            if callRegisterUser(landowner: landOwner) {
                self.performSegue(withIdentifier: "TabBarSegue", sender: self)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: {[alert] (_) in
            let landOwner = false
            if callRegisterUser(landowner: landOwner) {
                self.performSegue(withIdentifier: "TabBarSegue", sender: self)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        func callRegisterUser(landowner: Bool) -> Bool {
            guard let usernameText = usernameTextField.text, !usernameText.isEmpty,
                let passwordText = passwordTextField.text, !passwordText.isEmpty else { return false}
            let user = User(username: usernameText, password: passwordText, landowner: landowner)
            if !userController.registerUser(user: user) {
                //Alert Message registration failed
                let alert = UIAlertController(title: "Registration", message: "Registration failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else {
                //segue to Discover VC
                return true
            }
        }
    }
}
