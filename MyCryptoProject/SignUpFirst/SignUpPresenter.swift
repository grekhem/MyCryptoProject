//
//  SignUpFirstPresenter.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation

protocol ISignUpPresenter {
    func viewDidLoad(uiFirst: SignUpFirstView, uiSecond: SignUpSecondView)
    var changeUi: ((String, String) -> Void)? { get set }
    var error: ((ErrorUser) -> Void)? { get set }
}

final class SignUpPresenter {
    var changeUi: ((String, String) -> Void)?
    var error: ((ErrorUser) -> Void)?
    private weak var uiFirst: SignUpFirstView?
    private weak var uiSecond: SignUpSecondView?
    private var router: ISignUpRouter
    private var iteractor: ISignUpIteractor
    
    init(router: ISignUpRouter, iteractor: ISignUpIteractor) {
        self.router = router
        self.iteractor = iteractor
    }
}

extension SignUpPresenter: ISignUpPresenter {
    func viewDidLoad(uiFirst: SignUpFirstView, uiSecond: SignUpSecondView) {
        self.uiFirst = uiFirst
        self.uiSecond = uiSecond
        self.iteractor.enterToApp = { [weak self] in
            guard let self = self else { return }
            self.router.registrationEnd()
        }
        uiFirst.onTapSignInButton = { [weak self] in
            guard let self = self else { return }
            self.router.openAuthView()
        }
        uiFirst.onTapNextButton = { name, phone in
            self.changeUi?(name, phone)
        }
        uiSecond.onTapSignInButton = { [weak self] in
            guard let self = self else { return }
            self.router.openAuthView()
        }
        uiSecond.error = { [weak self] errorUser in
            guard let self = self else { return }
            self.error?(errorUser)
        }
        uiSecond.onTapReadyButton = { email, password, name, phone in
            self.iteractor.registerUser(email: email, password: password, name: name, phone: phone)
        }
    }
}

