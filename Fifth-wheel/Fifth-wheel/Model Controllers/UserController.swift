//
//  UserController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

// MARK: - Constants & Variables

var userController = UserController()

// MARK: - Object/Method definitions

class UserController {
    var users:              [User] = []
    var userAPIController = UserAPIController()
    var currentUser: User?
    
    init () {

    }
    
    func loginUser(user: User) -> Bool {
        currentUser = userAPIController.loginUser(user: user)
        if let _ = currentUser {
            return true
        } else {
            return false
        }
    }
    
    func registerUser (user: User) -> Bool {
        currentUser = userAPIController.registerUser(user: user)
        if let _ = currentUser {
            return true
        } else {
            return false
        }
    }
}
