//
//  HomeIteractor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import SwiftUI

protocol IHomeIteractor {
    var getArrayEntity: (([CryptoEntity]) -> Void)? { get set }
    var getUserInfo: ((UserModel) -> Void)? { get set }
    func fetchData()
    func update()
    func removeFromWatchlist(crypto: String) -> Void
}

class HomeIteractor {
    var getArrayEntity: (([CryptoEntity]) -> Void)?
    var getUserInfo: ((UserModel) -> Void)?
    private var user = UserModel()
    private var networkService: INetworkService
    private var data = [CryptoEntity]()
    private var watchlist: [String] = []
    
    init(networkService: INetworkService) {
        self.networkService = networkService
        self.getUser()
    }
    
}

extension HomeIteractor: IHomeIteractor {
    
    func removeFromWatchlist(crypto: String) -> Void {
        DatabaseService.shared.removeWatchlist(crypto: crypto)
        self.update()
    }
    
    func update() {
        guard let uid = AuthService.shared.getUserUID() else { return }
        DatabaseService.shared.getUser(uid: uid) { [weak self] user in
            guard let user = user, let self = self else { return }
            self.watchlist = user.watchlist ?? []
            self.fetchData()
            self.getPhoto(uid: user.uid)
        }
    }
    
    func getArrayModelWatchlist() {
        var array = [CryptoEntity]()
        for data in self.data {
            if self.watchlist.contains(where: { $0 == data.symbol }) {
                if array.contains(where: { $0.symbol == data.symbol}) == false {
                    array.append(data)
                }
            }
        }
        self.getArrayEntity?(array)
    }
    
    func fetchData() {
        self.networkService.loadData { (result: Result<CryptoDTO, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.modelingData(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Iteractor home: \(error.localizedDescription)")
                }
            }
        }
    }

}

private extension HomeIteractor {

    
    func getPhoto(uid: String?) {
        guard let uid = uid else { return }
        DatabaseService.shared.getImageFromDB(photoName: uid) { [weak self] image in
            guard let self = self else { return }
            self.user.photo = image
            self.getUserInfo?(self.user)
        }
    }
    
    func getUser() {
        guard let uid = AuthService.shared.getUserUID() else { return }
        DatabaseService.shared.getUser(uid: uid) { [weak self] user in
            guard let user = user, let self = self else { return }
            self.user = user
            self.watchlist = user.watchlist ?? []
            self.getUserInfo?(self.user)
            self.getPhoto(uid: user.uid)
        }
    }
    
    func modelingData(data: CryptoDTO) {
        var count = 0
        for i in 0..<data.data.count {
            count = count + 1
            var model = CryptoEntity()
            for (key, value) in data.data[i] {
                if let value = value {
                    switch key {
                    case "symbol":
                        model.symbol = value
                    case "priceUsd" :
                        let fmt = NumberFormatter()
                        let roundedPrice = String(format: "%.2f", Double(value) ?? 0)
                        if let price = Double(roundedPrice) {
                            fmt.numberStyle = .decimal
                            model.price = fmt.string(from: NSNumber(floatLiteral: price)) ?? ""
                        }
                    case "changePercent24Hr":
                        let roundedPercent = String(format: "%.1f", Double(value) ?? 0)
                        model.changePercent = roundedPercent
                        if value.first == "-" {
                            model.isRising = false
                        } else {
                            model.isRising = true
                        }
                    case "name" :
                        model.name = value
                    default:
                        continue
                    }
                }
            }
            self.data.append(model)
            if count == data.data.count {
                self.getArrayModelWatchlist()
            }
        }
    }
    
    
}
