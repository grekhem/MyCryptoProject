//
//  AuthorizationPresenter.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import Foundation

protocol IAuthorizationPresenter: AnyObject {
    func viewDidLoad(ui: IAuthorizationView)
    func checkAuth() -> Bool
    func resetPassword(email: String) -> Void
    var openResetPasswordAlert: (() -> Void)? { get set }
    var openResetSuccessAlert: (() -> Void)? { get set }
}

final class AuthorizationPresenter {
    var openResetPasswordAlert: (() -> Void)?
    var openResetSuccessAlert: (() -> Void)?
    private weak var ui: IAuthorizationView?
    private var router: IAuthorizationRouter
    private var iteractor: IAuthorizationIteractor
    
    init(router: IAuthorizationRouter, iteractor: IAuthorizationIteractor) {
        self.router = router
        self.iteractor = iteractor
    }
}

extension AuthorizationPresenter: IAuthorizationPresenter {
    func resetPassword(email: String) {
        self.iteractor.resetPassword(email: email)
    }
    
    func checkAuth() -> Bool {
        self.iteractor.chechAuth()
    }
    
    func viewDidLoad(ui: IAuthorizationView) {
        self.ui = ui
        ui.onTapRegisterButton = { [weak self] in
            guard let self = self else { return }
            self.router.openSignUpView()
        }
        ui.chechAuth = { [weak self] email, password in
            guard let self = self else { return }
            self.iteractor.checkUser(email: email, password: password)
        }
        ui.onTapForgotButton = {
            self.openResetPasswordAlert?()
        }
        self.iteractor.openApp = { [weak self] in
            self?.router.openApp()
        }
        self.iteractor.resetSuccess = { [weak self] in
            self?.openResetSuccessAlert?()
        }
    }
}
