//
//  SignUpFirstView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

protocol ISignUpSecondView {
    var onTapSignInButton: (() -> Void)? { get set }
    var error: ((ErrorUser) -> Void)? { get set }
    var onTapReadyButton: ((String, String) -> Void)? { get set }
}

final class SignUpSecondView: UIView {
    var onTapReadyButton: ((String, String) -> Void)?
    var error: ((ErrorUser) -> Void)?
    var onTapSignInButton: (() -> Void)?
    private var isCheck = false {
        willSet {
            if newValue == true {
                self.checkBox.setTitle("✓", for: .normal)
            } else if newValue == false {
                self.checkBox.setTitle("", for: .normal)
            }
        }
    }
    private let logoView = LogoSloganView(text: "Sign up")
    private let emailView = TextFieldView(text: "Email", placeholder: "Enter email")
    private let passwordView = TextFieldView(text: "Password", placeholder: "Enter password")
    private let confirmView = TextFieldView(text: "Confirm password", placeholder: "Confirm password")
    private let checkBox: UIButton = {
        let button = UIButton()
        button.layer.borderColor = Color.blue.color.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.enterButtonRadius
        button.setTitleColor(.black, for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(pressedCheckBox), for: .touchUpInside)
        return button
    }()
    private let agreeButton: UIButton = {
        let button = UIButton()
        let greenTextRange = NSRange(location: 11, length: 59)
        let range = NSRange(location: 0, length: 70)
        let string = "I agree to the Terms and Conditions, Privacy Policy and Content Policy"
        let attribute = NSMutableAttributedString.init(string: string)
        attribute.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: greenTextRange)
        attribute.addAttributes([NSAttributedString.Key.foregroundColor: Color.green.color], range: range)
        attribute.addAttributes([NSAttributedString.Key.font : AppFonts.mulishSemiBold12.font as Any], range: range)
        button.setAttributedTitle(attribute, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(pressedAgreeButton), for: .touchUpInside)
        return button
    }()
    private let readyButton = GreenButton(text: "READY")
    private let signInButton = UnderLineButton(text: "Already Have an Account? Sign in here", length: 37, locationLine: 25, lengthLine: 12)
    
    init() {
        super.init(frame: .zero)
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpSecondView: ISignUpSecondView {
    
}

private extension SignUpSecondView {
    func configUI() {
        self.backgroundColor = Color.gray.color
        self.configLogo()
        self.configEmailView()
        self.configPasswordView()
        self.configConfirmView()
        self.configCheckBox()
        self.configAgreeButton()
        self.configReadyButton()
        self.configSignInButton()
    }
    
    func configLogo() {
        self.addSubview(logoView)
        self.logoView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(Constraints.logoTop)
            make.centerX.equalToSuperview()
        }
    }
    
    func configEmailView() {
        self.addSubview(emailView)
        self.emailView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(Constraints.textFieldToLogoTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    
    func configPasswordView() {
        self.addSubview(passwordView)
        self.passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(Constraints.textFieldToTextFieldTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    
    func configConfirmView() {
        self.addSubview(confirmView)
        self.confirmView.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(Constraints.textFieldToTextFieldTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    
    func configCheckBox() {
        self.addSubview(checkBox)
        self.checkBox.snp.makeConstraints { make in
            make.top.equalTo(confirmView.snp.bottom).offset(Constraints.textFieldToTextFieldTop)
            make.leading.equalToSuperview().offset(Constraints.InsetHorizontal)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
    }
    
    func configAgreeButton() {
        self.agreeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubview(agreeButton)
        self.agreeButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkBox.snp.centerY)
            make.leading.equalTo(checkBox.snp.trailing).offset(14)
            make.height.equalTo(36)
            make.trailing.equalToSuperview().offset(-Constraints.InsetHorizontal)
        }
    }
    
    func configReadyButton() {
        self.readyButton.addTarget(self, action: #selector(pressedReadyButton), for: .touchUpInside)
        self.addSubview(readyButton)
        self.readyButton.snp.makeConstraints { make in
            make.top.equalTo(checkBox.snp.bottom).offset(Constraints.ButtonTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.height.equalTo(Constraints.enterButtonHeight)
        }
    }
    
    func configSignInButton() {
        self.signInButton.addTarget(self, action: #selector(pressedSignInButton), for: .touchUpInside)
        self.addSubview(signInButton)
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(readyButton.snp.bottom).offset(Constraints.ButtonTop)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().priority(.low)
        }
    }
    
    @objc func pressedSignInButton() {
        onTapSignInButton?()
    }
    
    @objc func pressedCheckBox() {
        self.isCheck.toggle()
    }
    
    @objc func pressedAgreeButton() {
        if let url = URL(string: "https://developer.apple.com/support/terms/") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func pressedReadyButton() {
        if let email = self.emailView.getTextFromField(), let password = self.passwordView.getTextFromField(), let confirm = self.confirmView.getTextFromField() {
            if password == confirm {
                if isCheck == true {
                    self.onTapReadyButton?(email, password)
                } else {
                    self.error?(.notCheck)
                }
            } else {
                self.error?(.notConfirmPassword)
            }
        }
    }
}
