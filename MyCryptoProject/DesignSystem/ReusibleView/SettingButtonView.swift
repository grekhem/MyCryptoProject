//
//  SettingButtonView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 23.06.2022.
//

import Foundation
import UIKit

final class SettingButtonView: UIView {
    private var onTapHandler: (() -> Void)?
    private lazy var onTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mulishBold16.font
        label.textColor = Color.darkGreen.color
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mulishRegular12.font
        label.textColor = Color.darkGrey.color
        return label
    }()
    private var arrowView: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    init(imageName: String, name: String, description: String, onTapHandler: (() -> Void)?) {
        super.init(frame: .zero)
        self.imageView.image = UIImage(named: imageName)
        self.nameLabel.text = name
        self.descriptionLabel.text = description
        self.onTapHandler = onTapHandler
        self.addGestureRecognizer(onTap)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingButtonView {
    
    func configUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.configImage()
        self.configName()
        self.configDescription()
        self.configArrow()
    }
    
    func configImage() {
        self.addSubview(imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(44)
        }
    }
    
    func configName() {
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
    }
    
    func configDescription() {
        self.addSubview(descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
    }
    
    func configArrow() {
        self.addSubview(arrowView)
        self.arrowView.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.onTapHandler?()
    }
}
