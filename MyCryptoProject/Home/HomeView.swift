//
//  HomeView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

protocol IHomeView: AnyObject {
    var watchlist: [CryptoEntity]? { get set }
    var user: UserModel? { get set }
    var addAlert: ((String) -> Void)? { get set }
    var updateData: (() -> Void)? { get set }
    func configCryptoView() -> Void
    func updateName() -> Void
    func updatePhoto() -> Void
    func updateGreeting(greeting: String) -> Void
}

final class HomeView: UIView {
    var updateData: (() -> Void)?
    var addAlert: ((String) -> Void)?
    var watchlist: [CryptoEntity]?
    var user: UserModel?
    let scrollView = UIScrollView()
    let contentView = UIView()
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morning,"
        label.font = AppFonts.mulishSemiBold12.font
        label.textColor = Color.lightGray.color
        label.textAlignment = .left
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = AppFonts.mulishBold20.font
        label.textColor = Color.darkGreen.color
        label.textAlignment = .left
        return label
    }()
    let updateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reload"), for: .normal)
        button.tintColor = .green
        return button
    }()
    let portofolioView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        return view
    }()
    let portofolioLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Portofolio"
        label.font = AppFonts.mulishSemiBold16.font
        label.textColor = Color.white.color
        return label
    }()
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "$56.98"
        label.font = AppFonts.mulishBold32.font
        label.textColor = Color.white.color
        return label
    }()
    private lazy var percentLabel: UIButton = {
        let button = UIButton()
        let attributedString = NSAttributedString(string: " 15.3%", attributes:
                                                    [NSAttributedString.Key.font : AppFonts.mulishBold12.font ?? UIFont.systemFont(ofSize: 12),
                                                     NSAttributedString.Key.foregroundColor : Color.green.color])
        button.setAttributedTitle(attributedString, for: .normal)
        button.setImage(UIImage(named: "arrowUpGreen"), for: .normal)
        button.backgroundColor = Color.white.color
        //        if self.isRising == true {
        //            button.setImage(UIImage(named: "arrowup"), for: .normal)
        //            button.backgroundColor = Color.green.color
        //        } else {
        //            button.setImage(UIImage(named: "arrowdown"), for: .normal)
        //            button.backgroundColor = Color.red.color
        //        }
        button.layer.cornerRadius = Constants.percentRadius
        return button
    }()
    let assetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Your assets"
        label.textAlignment = .left
        label.font = AppFonts.mulishSemiBold14.font
        label.textColor = Color.darkGreen.color
        return label
    }()
    let viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(Color.green.color, for: .normal)
        button.titleLabel?.font = AppFonts.mulishBold12.font
        return button
    }()
    let watchlistLabel: UILabel = {
        let label = UILabel()
        label.text = "Watchlist"
        label.textAlignment = .left
        label.font = AppFonts.mulishSemiBold14.font
        label.textColor = Color.darkGreen.color
        return label
    }()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let assetsView = AssetView(name: "Bitcoin", symbol: "BTC", total: "26.46", percent: "15.3", isRising: true, portofolioTotal: "0.0012")
    
}

extension HomeView: IHomeView {
    func updatePhoto() {
        self.photoImageView.image = self.user?.photo
        self.reloadInputViews()
    }
    func updateGreeting(greeting: String) -> Void {
        self.greetingLabel.text = greeting
    }
    func updateName() -> Void {
        self.nameLabel.text = self.user?.name
    }
    func configCryptoView() {
        let array = self.stackView.arrangedSubviews
        for i in array {
            i.removeFromSuperview()
        }
        if watchlist?.isEmpty == false {
            for i in watchlist! {
                let view = CryptoCurrencyView(name: i.name, symbol: i.symbol, price: i.price, percent: i.changePercent, isRising: i.isRising) { [weak self] symbol in
                    guard let self = self else { return }
                    self.addAlert?(symbol)
                }
                self.stackView.addArrangedSubview(view)
            }
        }
        self.reloadInputViews()
    }
}

private extension HomeView {
    func configUI() {
        configScrollView()
        configContentView()
        configPhotoView()
        configGreeting()
        configName()
        configUpdateButton()
        configPortofolioView()
        configPortofolioLabel()
        configTotalLabel()
        configPercent()
        configAssetsLabel()
        configViewAllButton()
        configAssetsView()
        configWatchlistLabel()
        configStackView()
    }
    func configScrollView() {
        self.addSubview(scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    func configContentView() {
        self.scrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    func configPhotoView() {
        self.contentView.addSubview(photoImageView)
        self.photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.photoAndGreetingTop)
            make.leading.equalToSuperview().offset(Constraints.InsetHorizontal)
            make.height.width.equalTo(40)
        }
    }
    func configGreeting() {
        self.contentView.addSubview(greetingLabel)
        self.greetingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.photoAndGreetingTop)
            make.leading.equalTo(photoImageView.snp.trailing).offset(Constraints.greetingNameLeadind)
        }
    }
    func configName() {
        self.contentView.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom)
            make.leading.equalTo(photoImageView.snp.trailing).offset(Constraints.greetingNameLeadind)
        }
    }
    func configUpdateButton() {
        self.updateButton.addTarget(self, action: #selector(pressedUpdateButton), for: .touchUpInside)
        self.contentView.addSubview(updateButton)
        self.updateButton.snp.makeConstraints { make in
            make.centerY.equalTo(photoImageView.snp.centerY).priority(.low)
            make.trailing.equalToSuperview().offset(-Constraints.InsetHorizontal).priority(.high)
            make.height.width.equalTo(24)
        }
    }
    func configPortofolioView() {
        self.contentView.addSubview(portofolioView)
        self.portofolioView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(Constraints.portfolioViewTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
        }
    }
    func configPortofolioLabel() {
        self.portofolioView.addSubview(portofolioLabel)
        self.portofolioLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.portfolioLabelTop)
            make.leading.equalToSuperview().offset(Constraints.portfolioLabelLeading)
        }
    }
    func configTotalLabel() {
        self.portofolioView.addSubview(totalLabel)
        self.totalLabel.snp.makeConstraints { make in
            make.top.equalTo(portofolioLabel.snp.bottom).offset(Constraints.totalLabelTop)
            make.leading.equalToSuperview().offset(Constraints.portfolioLabelLeading)
        }
    }
    func configPercent() {
        self.portofolioView.addSubview(percentLabel)
        self.percentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constraints.portfolioPercentTrailing)
            make.height.equalTo(32)
            make.width.equalTo(73)
        }
    }
    func configAssetsLabel() {
        self.contentView.addSubview(assetsLabel)
        self.assetsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constraints.InsetHorizontal)
            make.top.equalTo(portofolioView.snp.bottom).offset(Constraints.homeLabelTop)
        }
    }
    func configViewAllButton() {
        self.contentView.addSubview(viewAllButton)
        self.viewAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.centerY.equalTo(assetsLabel.snp.centerY)
        }
    }
    func configAssetsView() {
        self.contentView.addSubview(assetsView)
        self.assetsView.snp.makeConstraints { make in
            make.top.equalTo(assetsLabel.snp.bottom).offset(Constraints.cryptoViewVertical)
            make.leading.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.width.equalTo(190)
        }
    }
    func configWatchlistLabel() {
        self.contentView.addSubview(watchlistLabel)
        self.watchlistLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(Constraints.InsetHorizontal)
            make.top.equalTo(assetsView.snp.bottom).offset(Constraints.homeLabelTop)
        }
    }
    func configStackView() {
        self.contentView.addSubview(stackView)
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(watchlistLabel.snp.bottom).offset(Constraints.cryptoViewVertical)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.bottom.equalToSuperview()
        }
    }
    @objc func pressedUpdateButton() {
        self.updateData?()
        self.updateButton.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.5),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            self.updateButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: nil )
    }
}
