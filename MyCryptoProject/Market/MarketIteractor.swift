//
//  HomeIteractor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation

protocol IMarketIteractor {
    var getArrayEntity: (([CryptoEntity]) -> Void)? { get set }
    var getWatchlist: (([String]) -> Void)? { get set }
    func addWatchlist(crypto: String) -> Void
}

class MarketIteractor {
    var getArrayEntity: (([CryptoEntity]) -> Void)?
    var getWatchlist: (([String]) -> Void)?
    private var networkService: INetworkService
    private var cryptoArray: [CryptoEntity] = []
    
    init(networkService: INetworkService) {
        self.networkService = networkService
        self.fetchData()
        self.fetchWatchlist()
    }
}

extension MarketIteractor: IMarketIteractor {
    func addWatchlist(crypto: String) -> Void {
        DatabaseService.shared.addWatchlist(crypto: crypto)
    }
}

private extension MarketIteractor {
    func fetchWatchlist() {
        guard let uid = AuthService.shared.getUserUID() else { return }
        DatabaseService.shared.getUser(uid: uid) { [weak self] user in
            guard let user = user, let self = self else { return }
            self.getWatchlist?(user.watchlist ?? [])
        }
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
                    print("Iteractor market: \(error.localizedDescription)")
                }
            }
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
            self.cryptoArray.append(model)
            if count == data.data.count {
                self.getArrayEntity?(self.cryptoArray)
            }
        }
    }
}
