//
//  SignUpFirstIteractor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import FirebaseAuth

protocol ISignUpIteractor {
    func registerUser(email: String, password: String, name: String, phone: String)
    var enterToApp: (() -> Void)? { get set }
}

final class SignUpIteractor {
    var enterToApp: (() -> Void)?
}

extension SignUpIteractor: ISignUpIteractor {
    
    func createUser(name: String, phone: String, email: String, uid: String) {
        DatabaseService.shared.createUser(user: UserModel(name: name, phone: phone, email: email, uid: uid, photo: nil, watchlist: nil))
    }
    
    func registerUser(email: String, password: String, name: String, phone: String) {
        AuthService.shared.signUp(email: email, password: password) { (result: Result<User, Error>) in
            switch result {
            case .success( let user):
                DispatchQueue.main.async {
                    self.createUser(name: name, phone: phone, email: email, uid: user.uid)
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
