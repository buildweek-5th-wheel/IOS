//
//  UserAPIController.swift
//  Fifth-wheel
//
//  Created by Joshua Sharp on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class UserAPIController {
    func loginUser (user: User) -> User? {
        guard user.username != "",  user.password != "" else { return nil }
        var authUser: User = User(username: user.username, password: user.password, landowner: user.landowner)
        //API code to login user and store id and authToken in authUser to be returned
        return authUser
    }
    
    func registerUser (user: User) -> User? {
        guard user.username != "",  user.password != "" else { return nil }
        var authUser: User = User(username: user.username, password: user.password, landowner: user.landowner)
        //API code to register user and store id and authToken in authUser to be returned
        //Does registration login automatially?  If not Login
        return authUser
    }
}
