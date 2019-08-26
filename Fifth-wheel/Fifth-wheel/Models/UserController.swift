//
//  UserController.swift
//  Fifth-wheel
//
//  Created by Nathan Hedgeman on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class UserController {
    
    //Properties
    var loggedInUser: User?
    
}

// MARK: -CRUD
extension UserController {
    
    func createUser(username: String, password: String, landowner: Bool) -> User {
        let user = User(username: username, password: password, landowner: landowner)
        return user
    }
    
    func updateUser(password: String?, landowner: Bool?, bio: String?, image: String?) {
        guard let password = password,
        let landowner = landowner,
        let bio = bio,
        let image = image else {return}
        loggedInUser?.password = password
        loggedInUser?.bio = bio
        loggedInUser?.landowner = landowner
        loggedInUser?.imageURL = image
    }
    
    
}
