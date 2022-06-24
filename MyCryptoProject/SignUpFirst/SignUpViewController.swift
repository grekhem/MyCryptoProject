//
//  SignUpFirstViewController.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private var presenter: ISignUpPresenter?
    private var customViewFirst = SignUpFirstView()
    private var customViewSecond = SignUpSecondView()
    
    init(presenter: ISignUpPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        self.customViewFirst.backgroundColor = Color.gray.color
        self.customViewSecond.backgroundColor = Color.gray.color
    }
    
    override func loadView() {
        self.view = self.customViewFirst
        self.presenter?.viewDidLoad(uiFirst: customViewFirst, uiSecond: customViewSecond)
        self.presenter?.changeUi = { [weak self] name, phone in
            guard let self = self else { return }
            self.changeUI(name: name, phone: phone)
        }
        self.presenter?.error = { [weak self] errorUser in
            guard let self = self else { return }
            self.openAlert(error: errorUser)
        }
    }
}

private extension SignUpViewController {
    func changeUI(name: String, phone: String) {
        self.view = self.customViewSecond
        self.customViewSecond.name = name
        self.customViewSecond.phone = phone
    }
    func openAlert(error: ErrorUser){
        let alert = UIAlertController(title: "Error", message: error.text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
