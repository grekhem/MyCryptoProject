//
//  SignUpFirstIteractor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import FirebaseAuth

protocol ISignUpIteractor {
    func createUser(name: String, phone: String)
    func registerUser(email: String, password: String)
    var enterToApp: (() -> Void)? { get set }
}

final class SignUpIteractor {
    private var user = UserModel()
    var enterToApp: (() -> Void)?
}

extension SignUpIteractor: ISignUpIteractor {
    func registerUser(email: String, password: String) {
        self.user.email = email
        AuthService.shared.signUp(email: email, password: password) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if AuthService.shared.isSignIn == true {
                        self.user.uid = user.uid
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
    
    func createUser(name: String, phone: String) {
        self.user.name = name
        self.user.phone = phone
    }
}
