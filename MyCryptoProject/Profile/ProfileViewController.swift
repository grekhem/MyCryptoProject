//
//  HomeViewController.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    private var presenter: IProfilePresenter?
    private var customView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()    }
    
    override func loadView() {
        self.view = self.customView
        self.presenter?.viewDidLoad(ui: customView)
        self.presenter?.alert = { [weak self] in
            guard let self = self else { return }
            self.alertChooseImage()
        }
        self.presenter?.openPicker = { [weak self] picker in
            guard let self = self else { return }
            self.present(picker, animated: true, completion: nil)
        }
        self.presenter?.pickerAlert = { [weak self] alert in
            guard let self = self else { return }
            self.alertPicker(alert: alert)
        }
        self.presenter?.privasyAlert = { [weak self] in
            guard let self = self else { return }
            self.alertPrivasy()
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.customView.backgroundColor = Color.gray.color
    }
    
    init(presenter: IProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ProfileViewController {
    func alertPrivasy() {
        let alert = UIAlertController(title: "Change", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Email", style: .default, handler: { _ in
            self.emailAlert()
        }))
        alert.addAction(UIAlertAction(title: "Password", style: .default, handler: { _ in
            self.presenter?.changePassword()
            self.passwordAlert()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func alertPicker(alert: String) {
        let alert  = UIAlertController(title: "Warning", message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func alertChooseImage() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.presenter?.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.presenter?.openGallery()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func passwordAlert() {
        let alert = UIAlertController(title: "Password reset", message: "Check email", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func emailAlert() {
        let alert = UIAlertController(title: "New email", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "New email"
            textField.translatesAutoresizingMaskIntoConstraints = false
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .destructive)
        let alertActionCreateNote = UIAlertAction(title: "Change", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self.presenter?.changeEmail(email: text)
            }
        }
        alert.addAction(alertActionCancel)
        alert.addAction(alertActionCreateNote)
        self.present(alert, animated: true)
    }
}
