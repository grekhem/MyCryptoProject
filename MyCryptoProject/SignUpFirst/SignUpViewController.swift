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
    
    override func loadView() {
        self.view = self.customViewFirst
        self.presenter?.viewDidLoad(uiFirst: customViewFirst, uiSecond: customViewSecond)
        self.presenter?.changeUi = { [weak self] in
            guard let self = self else { return }
            self.view = self.customViewSecond
        }
        self.presenter?.error = { [weak self] errorUser in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Ошибка", message: errorUser.text, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

