//
//  AuthorizationView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import Foundation
import UIKit

protocol IAuthorizationView: AnyObject {
    var onTapRegisterButton: (() -> Void)? { get set }
    var onTapForgotButton: (() -> Void)? { get set }
    var chechAuth: ((String,String) -> Void)? { get set }
}

final class AuthorizationView: UIView {
    var onTapRegisterButton: (() -> Void)?
    var onTapForgotButton: (() -> Void)?
    var chechAuth: ((String,String) -> Void)?
    private let logoView = LogoSloganView(text: "Authorization")
    private let emailView = TextFieldView(text: "Email", placeholder: "Enter email")
    private let passwordView = TextFieldView(text: "Password", placeholder: "Enter password")
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(Color.yellow.color, for: .normal)
        button.titleLabel?.font = AppFonts.mulishSemiBold12.font
        return button
    }()
    private let enterButton = GreenButton(text: "ENTER")
    private let registerButton = UnderLineButton(text: "Don't have an account yet? Register here", length: 40, locationLine: 27, lengthLine: 13)
    init() {
        super.init(frame: .zero)
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthorizationView: IAuthorizationView {
    
}

private extension AuthorizationView {
    func configUI() {
        self.backgroundColor = Color.gray.color
        self.configLogo()
        self.configEmail()
        self.configPassword()
        self.configForgotButton()
        self.configEnterButton()
        self.configRegisterButton()
    }
    
    func configLogo() {
        self.addSubview(logoView)
        self.logoView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(Constraints.logoTop)
            make.centerX.equalToSuperview()
        }
    }
    
    func configEmail() {
        self.addSubview(emailView)
        self.emailView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(Constraints.textFieldToLogoTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    
    func configPassword() {
        self.addSubview(passwordView)
        self.passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(Constraints.textFieldToTextFieldTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    func configForgotButton() {
        self.forgotButton.addTarget(self, action: #selector(pressedForgotButton), for: .touchUpInside)
        self.addSubview(forgotButton)
        self.forgotButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(Constraints.forgotButtonTop)
            make.centerX.equalToSuperview()
        }
    }
    func configEnterButton() {
        self.enterButton.addTarget(self, action: #selector(pressedEnterButton), for: .touchUpInside)
        self.addSubview(enterButton)
        self.enterButton.snp.makeConstraints { make in
            make.top.equalTo(forgotButton.snp.bottom).offset(Constraints.ButtonTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.height.equalTo(Constraints.enterButtonHeight)
        }
    }
    func configRegisterButton() {
        self.registerButton.addTarget(self, action: #selector(pressedRegisterButton), for: .touchUpInside)
        self.addSubview(registerButton)
        self.registerButton.snp.makeConstraints { make in
            make.top.equalTo(enterButton.snp.bottom).offset(Constraints.ButtonTop)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().priority(.low)
        }
    }
    
    @objc func pressedRegisterButton() {
        self.onTapRegisterButton?()
    }
    
    @objc func pressedEnterButton() {
        if let email = self.emailView.getTextFromField(), let password = self.passwordView.getTextFromField() {
            self.chechAuth?(email, password)
        }
    }
    
    @objc func pressedForgotButton() {
        self.onTapForgotButton?()
    }
}
