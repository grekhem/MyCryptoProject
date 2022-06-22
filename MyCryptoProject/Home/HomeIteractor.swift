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
}

class HomeIteractor {
    var getArrayEntity: (([CryptoEntity]) -> Void)?
    private var networkService: INetworkService
    private var data = [CryptoEntity]()
    private var watchlist = ["BTC", "ETH", "XRP", "BCH", "EOS", "XLM", "LTC", "ADA", "USDT", "MIOTA"]
    
    init(networkService: INetworkService) {
        self.networkService = networkService
        self.fetchData()
    }
    
}

extension HomeIteractor: IHomeIteractor {
    
    func getArrayModelWatchlist() {
        var array = [CryptoEntity]()
        for data in self.data {
            if self.watchlist.contains(where: { $0 == data.symbol }) {
                array.append(data)
            }
        }
        self.getArrayEntity?(array)
    }

}

private extension HomeIteractor {
    
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
    
    func fetchData() {
        self.networkService.loadData { (result: Result<CryptoDTO, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.modelingData(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Presenter: \(error.localizedDescription)")
                }
            }
        }
    }
}
