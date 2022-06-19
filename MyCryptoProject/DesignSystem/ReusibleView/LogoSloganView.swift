//
//  LogoSloganView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

final class LogoSloganView: UIView {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoGreen")
        return imageView
    }()
    private let authLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mulishBold32.font
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    private let sloganLabel: UILabel = {
        let label = UILabel()
        label.text = "Trusted by millions of users worldwide"
        label.textColor = Color.green.color
        label.font = AppFonts.mulishSemiBold14.font
        return label
    }()
    
    init(text: String) {
        super.init(frame: .zero)
        self.authLabel.text = text
        self.configLogo()
        self.configAuthLabel()
        self.configSlogan()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LogoSloganView {
    
    func configLogo() {
        self.addSubview(logoImageView)
        self.logoImageView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func configAuthLabel() {
        self.addSubview(authLabel)
        self.authLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(logoImageView.snp.bottom).offset(Constraints.logoBottom)
            make.centerX.equalToSuperview()
        }
    }
    
    func configSlogan() {
        self.addSubview(sloganLabel)
        self.sloganLabel.snp.makeConstraints { make in
            make.top.equalTo(authLabel.snp.bottom).offset(Constraints.sloganTop)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
