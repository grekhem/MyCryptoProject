//
//  HomeAssembly.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

enum MarketAssembly {
    static func buildModule(networkService: INetworkService) -> UIViewController {
        let iteractor = MarketIteractor(networkService: networkService)
        let presenter = MarketPresenter(iteractor: iteractor)
        let controller = MarketViewController(presenter: presenter)
        return controller
    }
}
