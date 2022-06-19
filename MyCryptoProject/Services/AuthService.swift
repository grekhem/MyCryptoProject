//
//  AuthService.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import Foundation
import FirebaseAuth
import SwiftUI

final class AuthService {
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    private var currentUser: User? {
        return auth.currentUser
    }
    var isSignIn: Bool?
    
    private init(){
        let _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.isSignIn = false
            } else {
                self.isSignIn = true
            }
        }
    }
    
    func signUp(email: String, password: String, complition: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                complition(.success(result.user))
            } else if let error = error {
                complition(.failure(error))
            }
        }
    }
    
    func signIn(email: String, password: String, complition: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                complition(.success(result.user))
            } else if let error = error {
                complition(.failure(error))
            }
            
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func resetPassword(email: String, complition: @escaping (Error?) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                complition(error)
            } else {
                complition(error)
            }
        }
    }
}
