//
//  HomeView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

protocol IProfileView: AnyObject {
    var addAlert: (() -> Void)? { get set }
    var logOut: (() -> Void)? { get set }
    var privaсy: (() -> Void)? { get set }
    func changePhoto(photo: UIImage)
    func setName(name: String)
}

final class ProfileView: UIView {
    var privaсy: (() -> Void)?
    var logOut: (() -> Void)?
    var addAlert: (() -> Void)?
    private lazy var onEditPhoto = UITapGestureRecognizer(target: self, action: #selector(self.editPhoto(_:)))
    private let photoView = UIView()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    private let editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "edit")
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mulishBold24.font
        label.textColor = Color.darkGreen.color
        return label
    }()
    private var arrangementLabel: UILabel = {
        let label = UILabel()
        label.text = "Arrangement"
        label.font = AppFonts.mulishSemiBold16.font
        label.textColor = Color.darkGreen.color
        return label
    }()
    private lazy var privasyView = SettingButtonView(imageName: "privasy", name: "Privaсy", description: "Change email and password") {
        [weak self] in
        guard let self = self else { return }
        self.privaсy?()
    }
    private lazy var logOutView = SettingButtonView(imageName: "logout", name: "Log out", description: "Exit the app") {
        [weak self] in
        guard let self = self else { return }
        self.logOut?()
    }
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    func configUI() {
        configPhotoView()
        configImageView()
        configEditView()
        configNameLabel()
        configArrangementLabel()
        configPrivasy()
        configLogOut()
    }
    func configPhotoView() {
        self.photoView.addGestureRecognizer(onEditPhoto)
        self.addSubview(photoView)
        self.photoView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(80)
        }
    }
    func configImageView() {
        self.photoView.addSubview(imageView)
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configEditView() {
        self.photoView.addSubview(editImageView)
        self.editImageView.snp.makeConstraints { make in
            make.height.width.equalTo(28)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    func configNameLabel() {
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
    func configArrangementLabel() {
        self.addSubview(arrangementLabel)
        self.arrangementLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    func configPrivasy() {
        self.addSubview(privasyView)
        self.privasyView.snp.makeConstraints { make in
            make.top.equalTo(arrangementLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    func configLogOut() {
        self.addSubview(logOutView)
        self.logOutView.snp.makeConstraints { make in
            make.top.equalTo(privasyView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    @objc func editPhoto(_ sender: UITapGestureRecognizer? = nil) {
        self.addAlert?()
    }
}

extension ProfileView: IProfileView {
    func changePhoto(photo: UIImage) {
        self.imageView.image = photo
    }
    func setName(name: String) {
        self.nameLabel.text = name
    }
}
