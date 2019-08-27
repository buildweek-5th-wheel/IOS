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
    var userListings: [Listing] = []
    
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


//MARK: - Network Login and Signup
extension UserController {
    
    func signUp(with user: User, completion: @escaping (Error?) -> Void) {
        let appendedURL = baseURL.appendingPathComponent("auth/register")
        var request = URLRequest(url: appendedURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONEncoder().encode(user)
            request.httpBody = data
        } catch {
            NSLog("UserController: Error encoding user info: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NetworkError.failedSignUp(NSError(domain: baseURL.absoluteString, code: response.statusCode, userInfo: nil)))
                return
            }
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    //Get Token
    func signIn(with user: User, completion: @escaping (Error?) -> Void) {
        let appendedURL = baseURL.appendingPathComponent("auth/login")
        var request = URLRequest(url: appendedURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONEncoder().encode(user)
            request.httpBody = data
        } catch {
            NSLog("UserController: Error encoding user info: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NetworkError.failedSignUp(NSError(domain:  baseURL.absoluteString, code: response.statusCode, userInfo: nil)))
                return
            }
            if let error = error {
                completion(error)
                return
            }
            guard let data = data else { completion(NetworkError.invalidData); return}
            do {
                self.loggedInUser?.token = try JSONDecoder().decode(Bearer.self, from: data)
                self.saveUser()
            } catch {
                NSLog("UserController: Error decoding bearer token: \(error)")
                completion(NetworkError.noDecode)
                return
            }
            completion(nil)
        }.resume()
    }
}

