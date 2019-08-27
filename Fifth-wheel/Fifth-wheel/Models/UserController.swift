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
    
    private var userInfo: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else    { return nil }
        return documentsDirectory.appendingPathComponent("fillout.plist")
    }
}

// MARK: -CRUD
extension UserController {
    
    func createUser(username: String, password: String, landowner: Bool) {
        let user = User(username: username, password: password, landowner: landowner)
        loggedInUser = user
        saveUser()
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
        saveUser()
    }
}

//Data functions
extension UserController {
    
    func saveUser(){
        guard let url = userInfo else {return print("Url not created in directory")}
        do {
            let user = try PropertyListEncoder().encode(self.loggedInUser)
            try user.write(to: url)
        } catch {
            NSLog("Error user data: \(error) ")
        }
    }
}
