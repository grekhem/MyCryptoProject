//
//  CryptoCurrencyView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 21.06.2022.
//

import Foundation
import UIKit

final class CryptoCurrencyView: UIView {
    
    let name: String
    let symbol: String
    let price: String
    let percent: String
    let isRising: Bool
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: self.symbol.lowercased()) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "dollar")
        }
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.text = self.symbol
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishBold20.font
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = self.name
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishRegular16.font
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$\(self.price)"
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishBold16.font
        return label
    }()
    lazy var percentLabel: UIButton = {
        let button = UIButton()
        let attributedString = NSAttributedString(string: "\(self.percent)%", attributes:
                                                    [NSAttributedString.Key.font : AppFonts.mulishBold10.font ?? UIFont.systemFont(ofSize: 10),
                                                     NSAttributedString.Key.foregroundColor : UIColor.white])
        button.setAttributedTitle(attributedString, for: .normal)
        if self.isRising == true {
            button.setImage(UIImage(named: "arrowup"), for: .normal)
            button.backgroundColor = Color.green.color
        } else {
            button.setImage(UIImage(named: "arrowdown"), for: .normal)
            button.backgroundColor = Color.red.color
        }
        button.layer.cornerRadius = Constants.percentRadius
        return button
    }()
    
    
    init(name: String, symbol: String, price: String, percent: String, isRising: Bool) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.percent = percent
        self.isRising = isRising
        super.init(frame: .zero)
        self.configUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


private extension CryptoCurrencyView {
    func configUi() {
        self.backgroundColor = .white
        self.layer.cornerRadius = Constants.cryptoViewRadius
        configIcon()
        configSymbol()
        configName()
        configPrice()
        configPercent()
    }
    
    func configIcon() {
        self.addSubview(iconImageView)
        self.iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.cryptoIconVertical)
            make.leading.equalToSuperview().offset(Constraints.cryptoHorizontal)
            make.height.width.equalTo(64)
        }
    }
    
    func configSymbol() {
        self.addSubview(symbolLabel)
        self.symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constraints.cryptoNameSymbolLeading)
            make.top.equalToSuperview().offset(Constraints.cryptoSymbolTop)
        }
    }
    
    func configName() {
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constraints.cryptoNameSymbolLeading)
            make.top.equalTo(symbolLabel.snp.bottom).offset(Constraints.cryptoNameTop)
        }
    }
    
    func configPrice() {
        self.addSubview(priceLabel)
        self.priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(symbolLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-Constraints.cryptoHorizontal)
        }
    }
    
    func configPercent() {
        self.addSubview(percentLabel)
        self.percentLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalTo(55)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-Constraints.cryptoHorizontal)
        }
    }
}
