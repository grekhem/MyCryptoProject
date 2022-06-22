//
//  DatabaseService.swift
//  MyCryptoProject
//
//  Created by Grekhem on 22.06.2022.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseDatabase
import FirebaseFirestore
import UIKit

final class DatabaseService {
    
    static let shared = DatabaseService()
    private let collection = "users"
    
    private func configFireBase() -> Firestore {
        var db: Firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    private init() {
        
    }
    
    func createUser(user: UserModel) {
        guard let uid = user.uid else { return }
        let db = self.configFireBase()
        let data: [String: Any] = [
            "name": "\(user.name ?? "")",
            "phone": "\(user.phone ?? "")",
            "email": "\(user.email ?? "")",
            "uid": "\(user.uid ?? "")",
            "watchlist": user.watchlist ?? []
        ]
        db.collection(self.collection).document(uid).setData(data)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getUser(uid: String, complition: @escaping ((UserModel?) -> Void )) {
        let db = self.configFireBase()
        db.collection(self.collection).document(uid).getDocument { user, error in
            guard error == nil else { complition(nil); return }
            if let name = user?.get("name") as? String,
               let phone = user?.get("phone") as? String,
               let email = user?.get("email") as? String,
               let uid = user?.get("uid") as? String {
                let user = UserModel(name: name, phone: phone, email: email, uid: uid, watchlist: user?.get("watchlist") as? [String])
                complition(user)
            }
        }
    }
    
    func getImageFromDB(photoName: String, comlition: @escaping ((UIImage?) -> Void)) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("photo")
        var image: UIImage? = UIImage(named: "person")
        let fileRef = pathRef.child(photoName + ".jpg")
        fileRef.getData(maxSize: 1300*1300) { data, error in
            print("data - \(data)")
            guard error == nil else { comlition(image); print(error); return }
            if let data = data {
                image = UIImage(data: data)
                comlition(image)
            } else {
                comlition(image)
            }
        }
    }
    
}
