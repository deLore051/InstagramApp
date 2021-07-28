//
//  AuthManager.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 22.7.21..
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    private init() { }
    
    //MARK: - Public
    
    public func registerNewUser(username: String,
                                email: String, password: String,
                                completion: @escaping (Bool) -> Void) {
        /*  - Check if username is available
            - Check if email is available
         */
        DatabaseManger.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                // - Create account
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard error == nil, authResult != nil else {
                        // Firebase auth could not create account.
                        completion(false)
                        return
                    }
                    // - Add account to database
                    DatabaseManger.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // Eather username or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // Email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            // Username log in
            print(username)
        }
    }
    
    /// Attempt to log out firebase user
    public func logOut(comletion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            comletion(true)
            return
        } catch {
            print(error)
            comletion(false)
            return
        }
    }
}
