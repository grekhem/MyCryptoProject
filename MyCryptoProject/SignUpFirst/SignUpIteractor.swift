//
//  SignUpFirstIteractor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import FirebaseAuth

protocol ISignUpIteractor {
    func registerUser(email: String, password: String)
    var enterToApp: (() -> Void)? { get set }
}

final class SignUpIteractor {
    var enterToApp: (() -> Void)?
}

extension SignUpIteractor: ISignUpIteractor {
    func registerUser(email: String, password: String) {
        AuthService.shared.signUp(email: email, password: password) { (result: Result<User, Error>) in
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    if AuthService.shared.isSignIn == true {
                        self.enterToApp?()
                    }
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure)
                }
            }
        }
    }
}
