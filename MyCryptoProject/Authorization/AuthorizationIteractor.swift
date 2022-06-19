//
//  AuthorizationIteractor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import Foundation
import FirebaseAuth

protocol IAuthorizationIteractor: AnyObject {
    func chechAuth() -> Bool
    func checkUser(email: String, password: String)
    func resetPassword(email: String)
    var openApp: (() -> Void)? { get set }
    var resetSuccess: (() -> Void)? { get set }
}

final class AuthorizationIteractor {
    var openApp: (() -> Void)?
    var resetSuccess: (() -> Void)?
}

extension AuthorizationIteractor: IAuthorizationIteractor {
    
    func resetPassword(email: String) {
        AuthService.shared.resetPassword(email: email) { error in
            if let error = error {
                print(error)
            } else {
                self.resetSuccess?()
            }
        }
    }
    
    func checkUser(email: String, password: String) {
        AuthService.shared.signIn(email: email, password: password) { (result: Result<User, Error>) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.openApp?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func chechAuth() -> Bool {
        if let auth = AuthService.shared.isSignIn {
            return auth
        } else {
            return false
        }
    }
}
