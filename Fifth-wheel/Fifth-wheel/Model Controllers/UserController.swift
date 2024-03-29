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
    var userListings:       [Listing] = []
    var loggedInUser:       User?
    
    private var userInfo: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else    { return nil }
        return documentsDirectory.appendingPathComponent("fillout.plist")
    }
    
    init () {

    }
}

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
        userController.loggedInUser?.password = password
        userController.loggedInUser?.bio = bio
        userController.loggedInUser?.landowner = landowner
        userController.loggedInUser?.imageURL = image
        saveUser()
    }
}

//Data functions
extension UserController {
    
    func saveUser(){
        guard let url = userInfo else {return print("Url not created in directory")}
        do {
            let user = try PropertyListEncoder().encode(userController.loggedInUser)
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
                //TODO: Read all fields from return and put into user
                userController.loggedInUser = user
                userController.loggedInUser?.token = try JSONDecoder().decode(Bearer.self, from: data)
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

//MARK: - Network Route Calls
extension UserController {
    
    func getAllUsers(completion: @escaping (NetworkError?) -> Void) {
        guard let token = userController.loggedInUser?.token else {
            completion(.badAuth)
            return
        }
        let allUsersUrl = baseURL.appendingPathComponent("users")
        var request = URLRequest(url: allUsersUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.otherError(NSError()))
                return
            }
            if let error = error {
                completion(.otherError(error))
                return
            }
            guard let data = data else {
                completion(.noData)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                userController.users = try decoder.decode([User].self, from: data)
                completion(nil)
            } catch {
                completion(.otherError(error))
                return
            }
            }.resume()
    }
}
