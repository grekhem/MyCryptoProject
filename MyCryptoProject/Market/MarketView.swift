//
//  HomeView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

protocol IMarketView: AnyObject {
    func setData(crypto: [CryptoEntity])
    var addWatchlist: ((String) -> Void)? { get set }
    var watchlist: [String] { get set }
    var addAlert: ((String) -> Void)? { get set }
}

final class MarketView: UIView {
    var addAlert: ((String) -> Void)?
    var watchlist: [String] = []
    var addWatchlist: ((String) -> Void)?
    private var cryptoArray: [CryptoEntity] = []
    private var cryptoArrayFiltred: [CryptoEntity] = []
    private let tableView = UITableView()
    private lazy var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.layer.borderColor = Color.lightGreen.color.cgColor
        textfield.layer.cornerRadius = Constants.textFieldRadius
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [
                NSAttributedString.Key.font: AppFonts.mulishRegular14.font as Any,
                NSAttributedString.Key.foregroundColor: Color.lightGray.color
            ]
        )
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: 19))
        let imageView = UIImageView(frame: CGRect(x: -19, y: 0, width: 16, height: 16))
        imageView.image = UIImage(named: "loupe")
        textfield.rightView?.addSubview(imageView)
        textfield.leftViewMode = .always
        textfield.rightViewMode = .always
        textfield.autocorrectionType = .no
        textfield.delegate = self
        return textfield
    }()
    
    init() {
        super.init(frame: .zero)
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MarketView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        if textField.text! == "" {
            self.cryptoArrayFiltred = self.cryptoArray
        } else {
            if let text = textField.text?.lowercased() {
                self.cryptoArrayFiltred = self.cryptoArray.filter { crypto in
                    return crypto.symbol.lowercased().contains(text) ||
                    crypto.name.lowercased().contains(text)
                }
            }
        }
        self.tableView.reloadData()
        return true
    }
}

private extension MarketView {
    
    func configUI() {
        self.configTextField()
        self.setupTable()
        self.configureTable()
    }
    
    func configTextField() {
        self.addSubview(searchTextField)
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(Constraints.marketTextFieldTop)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.height.equalTo(40)
        }
    }
    
    func setupTable() {
        self.addSubview(self.tableView)
        self.tableView.backgroundColor = .clear
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(Constraints.cryptoViewVertical)
            make.leading.trailing.equalToSuperview().inset(Constraints.InsetHorizontal)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(MarketViewCell.self, forCellReuseIdentifier: MarketViewCell.id)
    }
}

extension MarketView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cryptoArrayFiltred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MarketViewCell(style: .default,
                                  reuseIdentifier: MarketViewCell.id,
                                  name: cryptoArrayFiltred[indexPath.row].name,
                                  symbol: cryptoArrayFiltred[indexPath.row].symbol,
                                  price: cryptoArrayFiltred[indexPath.row].price,
                                  percent: cryptoArrayFiltred[indexPath.row].changePercent,
                                  isRising: cryptoArrayFiltred[indexPath.row].isRising)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Favourite") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            if self.watchlist.contains(self.cryptoArrayFiltred[indexPath.row].symbol) != true {
                self.addWatchlist?(self.cryptoArrayFiltred[indexPath.row].symbol)
                self.watchlist.append(self.cryptoArrayFiltred[indexPath.row].symbol)
                self.addAlert?("Successfully added")
            } else {
                self.addAlert?("Already added")
            }
            completionHandler(true)
        }
        action.backgroundColor = Color.green.color
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension MarketView: IMarketView {
    
    func setData(crypto: [CryptoEntity]) {
        self.cryptoArray = crypto
        self.cryptoArrayFiltred = crypto
        self.tableView.reloadData()
    }
}
