//
//  DatabaseManger.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 22.7.21..
//

import Foundation
import FirebaseDatabase

public class DatabaseManger {
    
    static let shared = DatabaseManger()
    private let db = Database.database().reference()
    
    private init() { }
    
    //MARK: - Public
    
    /// Check if username and email are available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Inserts new user data to database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        db.child(email.safeDatabaseKey()).setValue(["username": username]) { error, dbReference in
            if error == nil {
                // Succeeded
                completion(true)
                return
            } else {
                // Failed
                completion(false)
                return
            }
        }
    }
   
}
