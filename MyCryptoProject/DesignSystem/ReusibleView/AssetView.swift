//
//  AssetView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 23.07.2022.
//

import Foundation
import UIKit

final class AssetView: UIView {
    private let name: String
    private let symbol: String
    private let total: String
    private let percent: String
    private let isRising: Bool
    private let portofolioTotal: String
    private let viewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = Color.gray.color
        return view
    }()
    private let portofolioLabel: UILabel = {
        let label = UILabel()
        label.text = "Portfolio"
        label.font = AppFonts.mulishRegular10.font
        label.textColor = Color.darkGrey.color
        return label
    }()
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
        label.font = AppFonts.mulishBold16.font
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = self.name
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishRegular10.font
        return label
    }()
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "$\(self.total)"
        label.textColor = Color.darkGreen.color
        label.font = AppFonts.mulishBold14.font
        return label
    }()
    private lazy var portofolioTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.portofolioTotal) \(self.symbol)"
        label.textColor = Color.darkGrey.color
        label.font = AppFonts.mulishBold10.font
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
    
    init(name: String, symbol: String, total: String, percent: String, isRising: Bool, portofolioTotal: String) {
        self.name = name
        self.symbol = symbol
        self.total = total
        self.percent = percent
        self.isRising = isRising
        self.portofolioTotal = portofolioTotal
        super.init(frame: .zero)
        self.configUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AssetView {
    func configUi() {
        self.backgroundColor = Color.white.color
        self.layer.cornerRadius = Constants.assetViewRadius
        configImage()
        configSymbolLabel()
        configNameLabel()
        configPercentLabel()
        configSeparator()
        configPortfolioLabel()
        configTotalLabel()
        configPortfolioTotalLabel()
    }
    func configImage() {
        self.addSubview(iconImageView)
        self.iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.assetsHorizontalVerticalInset)
            make.leading.equalToSuperview().offset(Constraints.assetsHorizontalVerticalInset)
        }
    }
    func configSymbolLabel() {
        self.addSubview(symbolLabel)
        self.symbolLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.assetSymbolTop)
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constraints.assetSymbolNameLeading)
        }
    }
    func configNameLabel() {
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom).offset(Constraints.assetLabelsTop)
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constraints.assetSymbolNameLeading)
        }
    }
    func configPercentLabel() {
        self.addSubview(percentLabel)
        self.percentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(Constraints.assetsHorizontalVerticalInset)
            make.height.equalTo(22)
            make.width.equalTo(55)
        }
    }
    func configSeparator() {
        self.addSubview(viewSeparator)
        self.viewSeparator.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(Constraints.assetSeparatorVertical)
            make.leading.trailing.equalToSuperview().inset(Constraints.assetsHorizontalVerticalInset)
            make.height.equalTo(2)
        }
    }
    func configPortfolioLabel() {
        self.addSubview(portofolioLabel)
        self.portofolioLabel.snp.makeConstraints { make in
            make.top.equalTo(viewSeparator.snp.bottom).offset(Constraints.assetSeparatorVertical)
            make.leading.equalToSuperview().offset(Constraints.assetsHorizontalVerticalInset)
        }
    }
    func configTotalLabel() {
        self.addSubview(totalLabel)
        self.totalLabel.snp.makeConstraints { make in
            make.top.equalTo(portofolioLabel.snp.bottom).offset(Constraints.assetLabelsTop)
            make.leading.equalToSuperview().offset(Constraints.assetsHorizontalVerticalInset)
            make.bottom.equalToSuperview().inset(Constraints.assetsHorizontalVerticalInset)
        }
    }
    func configPortfolioTotalLabel() {
        self.addSubview(portofolioTotalLabel)
        self.portofolioTotalLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(Constraints.assetsHorizontalVerticalInset)
        }
    }
}
