//
//  CryptoCurrencyView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 21.06.2022.
//

import Foundation
import UIKit

final class MarketViewCell: UITableViewCell {
    
    private let name: String
    private let symbol: String
    private let price: String
    private let percent: String
    private let isRising: Bool
    private let view = UIView()
    lazy var spacingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 10))
    
    static let id = String(describing: MarketViewCell.self)
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: self.symbol.lowercased()) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "dollar")
        }
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.text = self.symbol
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishBold20.font
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = self.name
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishRegular16.font
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$\(self.price)"
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishBold16.font
        return label
    }()
    private lazy var percentLabel: UIButton = {
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
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, name: String, symbol: String, price: String, percent: String, isRising: Bool) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.percent = percent
        self.isRising = isRising
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


private extension MarketViewCell {
    func configUi() {
    
        self.spacingView.backgroundColor = .green
        configView()
        configIcon()
        configSymbol()
        configName()
        configPrice()
        configPercent()
        configSpacing()
    }
    
    func configView() {
        self.addSubview(view)
        self.backgroundColor = Color.gray.color
        self.view.layer.cornerRadius = Constants.cryptoViewRadius
        self.view.backgroundColor = UIColor.white
        self.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configIcon() {
        self.view.addSubview(iconImageView)
        self.iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.cryptoIconVertical)
            make.bottom.equalToSuperview().inset(Constraints.cryptoIconVertical)
            make.leading.equalToSuperview().offset(Constraints.cryptoHorizontal)
            make.height.width.equalTo(64)
        }
    }
    
    func configSymbol() {
        self.view.addSubview(symbolLabel)
        self.symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constraints.cryptoNameSymbolLeading)
            make.top.equalToSuperview().offset(Constraints.cryptoSymbolTop)
        }
    }
    
    func configName() {
        self.view.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constraints.cryptoNameSymbolLeading)
            make.top.equalTo(symbolLabel.snp.bottom).offset(Constraints.cryptoNameTop)
        }
    }
    
    func configPrice() {
        self.view.addSubview(priceLabel)
        self.priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(symbolLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-Constraints.cryptoHorizontal)
        }
    }
    
    func configPercent() {
        self.view.addSubview(percentLabel)
        self.percentLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalTo(55)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-Constraints.cryptoHorizontal)
        }
    }
    
    func configSpacing() {
        self.addSubview(spacingView)
        self.spacingView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.bottom)
            make.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        
    }
}
