//
//  TextFieldView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import SnapKit
import UIKit

final class TextFieldView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.font = AppFonts.montserratMedium14.font
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private let textField: UITextField = {
        let textfield = UITextField()
        textfield.font = AppFonts.mulishSemiBold14.font
        textfield.textColor = UIColor(red: 93/255, green: 92/255, blue: 93/255, alpha: 1)
        textfield.layer.cornerRadius = Constants.textFieldRadius
        textfield.layer.borderColor = Color.lightGreen.color.cgColor
        textfield.backgroundColor = .white
        textfield.layer.borderWidth = 1
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textfield.leftViewMode = .always
        return textfield
    }()
    
    init(text: String, placeholder: String) {
        self.label.text = text
        self.textField.placeholder = placeholder
        super.init(frame: .zero)
        self.configUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTextFromField() -> String? {
        if textField.text != "" {
            return textField.text
        } else {
            return nil
        }
        
    }
}

private extension TextFieldView {
    
    func configUi() {
        self.configLabel()
        self.configTextField()
    }
    
    func configLabel() {
        self.addSubview(label)
        self.label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    func configTextField() {
        self.addSubview(textField)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(Constraints.textFieldLabelVertical)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.textFieldHeigth)
            make.bottom.equalToSuperview()
        }
    }
}
