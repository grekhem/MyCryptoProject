//
//  HomeIteractor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

protocol IProfileIteractor {
    var getUser: ((UserModel) -> Void)? { get set }
    func uploadPhoto(photo: UIImage)
    func logOut()
    func changePassword()
    func changeEmail(email: String)
}

class ProfileIteractor {
    var getUser: ((UserModel) -> Void)?
    private var user = UserModel()

    init() {
        self.getPhotoFromDB()
        self.getUserFromDB()
    }
}

extension ProfileIteractor: IProfileIteractor {
    func changePassword() {
        guard let email = AuthService.shared.getUserEmail() else { return }
        print(email)
        AuthService.shared.resetPassword(email: email) { error in
            if let error = error {
                print(error)
            }
        }
    }
    func changeEmail(email: String) {
        AuthService.shared.changeEmail(email: email)
    }
    func logOut() {
        AuthService.shared.signOut()
    }
    func uploadPhoto(photo: UIImage) {
        guard let uid = AuthService.shared.getUserUID() else { return }
        DatabaseService.shared.uploadImage(photoName: uid, photo: photo) { result in
            switch result{
            case .success(let url):
                print(url)
            case .failure(let error):
                print(error)
            }
        }
    }
}

private extension ProfileIteractor {
    func getPhotoFromDB() {
        guard let uid = AuthService.shared.getUserUID() else { return }
        DatabaseService.shared.getImageFromDB(photoName: uid) { [weak self] image in
            guard let self = self else { return }
            self.user.photo = image
            self.getUser?(self.user)
        }
    }
    func getUserFromDB() {
        guard let uid = AuthService.shared.getUserUID() else { return }
        DatabaseService.shared.getUser(uid: uid) { [weak self] user in
            guard let user = user, let self = self else { return }
            self.user = user
            self.getUser?(self.user)
        }
    }
}
