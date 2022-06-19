//
//  SignUpFirstView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

protocol ISignUpFirstView {
    var onTapSignInButton: (() -> Void)? { get set }
    var onTapNextButton: ((String, String) -> Void)? { get set }
}

final class SignUpFirstView: UIView {
    var onTapNextButton: ((String, String) -> Void)?
    var onTapSignInButton: (() -> Void)?
    private let logoView = LogoSloganView(text: "Sign up")
    private let nameView = TextFieldView(text: "Full name", placeholder: "User's full name")
    private let phoneView = TextFieldView(text: "Phone number", placeholder: "Phone number that can be contacted")
    private let nextButton = GreenButton(text: "NEXT")
    private let signInButton = UnderLineButton(text: "Already Have an Account? Sign in here", length: 37, locationLine: 25, lengthLine: 12)
    
    init() {
        super.init(frame: .zero)
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpFirstView: ISignUpFirstView {
    
}

private extension SignUpFirstView {
    func configUI() {
        self.backgroundColor = Color.gray.color
        self.configLogo()
        self.configNameView()
        self.configPhoneView()
        self.configNextButton()
        self.configSignInButton()
    }
    
    func configLogo() {
        self.addSubview(logoView)
        self.logoView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(Constraints.logoTop)
            make.centerX.equalToSuperview()
        }
    }
    
    func configNameView() {
        self.addSubview(nameView)
        self.nameView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(Constraints.textFieldToLogoTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    
    func configPhoneView() {
        self.addSubview(phoneView)
        self.phoneView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(Constraints.textFieldToTextFieldTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    
    func configNextButton() {
        self.nextButton.addTarget(self, action: #selector(pressedNextButton), for: .touchUpInside)
        self.addSubview(nextButton)
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).offset(Constraints.ButtonTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.height.equalTo(Constraints.enterButtonHeight)
        }
    }
    
    func configSignInButton() {
        self.signInButton.addTarget(self, action: #selector(pressedSignInButton), for: .touchUpInside)
        self.addSubview(signInButton)
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(Constraints.ButtonTop)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().priority(.low)
        }
    }
    
    @objc func pressedSignInButton() {
        onTapSignInButton?()
    }
    
    @objc func pressedNextButton() {
        if let name = self.nameView.getTextFromField(), let phone = self.phoneView.getTextFromField() {
            onTapNextButton?(name, phone)
        }
    }
}
