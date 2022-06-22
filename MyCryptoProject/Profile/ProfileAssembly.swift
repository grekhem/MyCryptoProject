//
//  HomeAssembly.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

enum ProfileAssembly {
    static func buildModule() -> UIViewController {
        let router = ProfileRouter()
        let iteractor = ProfileIteractor()
        let presenter = ProfilePresenter(router: router, iteractor: iteractor)
        let controller = ProfileViewController(presenter: presenter)
        router.vc = controller
        return controller
    }
}
