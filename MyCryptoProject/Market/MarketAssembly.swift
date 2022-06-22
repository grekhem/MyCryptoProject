//
//  HomeAssembly.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

enum MarketAssembly {
    static func buildModule() -> UIViewController {
        let router = MarketRouter()
        let iteractor = MarketIteractor()
        let presenter = MarketPresenter(router: router, iteractor: iteractor)
        let controller = MarketViewController(presenter: presenter)
        router.vc = controller
        return controller
    }
}
