//
//  HomeAssembly.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

enum HomeAssembly {
    static func buildModule(networkService: INetworkService) -> UIViewController {
        let iteractor = HomeIteractor(networkService: networkService)
        let presenter = HomePresenter(iteractor: iteractor)
        let controller = HomeViewController(presenter: presenter)
        return controller
    }
}
