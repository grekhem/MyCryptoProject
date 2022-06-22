//
//  HomeAssembly.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

enum HomeAssembly {
    static func buildModule(networkService: INetworkService) -> UIViewController {
        let router = HomeRouter()
        let iteractor = HomeIteractor(networkService: networkService)
        let presenter = HomePresenter(router: router, iteractor: iteractor)
        let controller = HomeViewController(presenter: presenter)
        router.vc = controller
        return controller
    }
}
