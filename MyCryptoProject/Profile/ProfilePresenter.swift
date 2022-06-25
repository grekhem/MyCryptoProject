//
//  HomePresentor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

protocol IProfilePresenter {
    var privasyAlert: (() -> Void)? { get set }
    var alert: (() -> Void)? { get set }
    var libraryAlert: (() -> Void)? { get set }
    var pickerAlert: ((String) -> Void)? { get set }
    var openPicker: ((UIImagePickerController) -> Void)? { get set }
    func viewDidLoad(ui: IProfileView)
    func openGallery()
    func openCamera()
    func changePassword()
    func changeEmail(email: String)
}

final class ProfilePresenter: NSObject {
    var privasyAlert: (() -> Void)?
    var pickerAlert: ((String) -> Void)?
    var alert: (() -> Void)?
    var libraryAlert: (() -> Void)?
    var openPicker: ((UIImagePickerController) -> Void)?
    private weak var ui: IProfileView?
    private var router: IProfileRouter
    private var iteractor: IProfileIteractor
    private lazy var libraryImagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        return imagePicker
    }()
    private lazy var cameraImagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
    init(router: IProfileRouter, iteractor: IProfileIteractor) {
        self.router = router
        self.iteractor = iteractor
    }
}

extension ProfilePresenter: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.ui?.changePhoto(photo: selectedImage)
        self.iteractor.uploadPhoto(photo: selectedImage)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfilePresenter: IProfilePresenter {
    func changePassword() {
        self.iteractor.changePassword()
    }
    func changeEmail(email: String) {
        self.iteractor.changeEmail(email: email)
    }
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            self.openPicker?(self.libraryImagePicker)
        } else {
            self.pickerAlert?("You don't have permission to access gallery.")
        }
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            self.openPicker?(self.cameraImagePicker)
        } else {
            self.pickerAlert?("You don't have camera")
        }
    }
    func viewDidLoad(ui: IProfileView) {
        self.ui = ui
        ui.addAlert = { [weak self] in
            guard let self = self else { return }
            self.alert?()
        }
        self.iteractor.getUser = { [weak self] user in
            guard let self = self else { return }
            if let photo = user.photo {
                self.ui?.changePhoto(photo: photo)
            }
            if let name = user.name {
                self.ui?.setName(name: name)
            }
        }
        self.ui?.logOut = { [weak self] in
            guard let self = self else { return }
            self.iteractor.logOut()
            self.router.logOut()
        }
        self.ui?.privaсy = { [weak self] in
            guard let self = self else { return }
            self.privasyAlert?()
        }
    }
}
