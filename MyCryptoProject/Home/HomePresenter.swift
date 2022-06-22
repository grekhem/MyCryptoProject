//
//  HomePresentor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation

protocol IHomePresenter {
    func viewDidLoad(ui: IHomeView)
}

final class HomePresenter {
    private weak var ui: IHomeView?
    private var router: IHomeRouter
    private var iteractor: IHomeIteractor
    
    init(router: IHomeRouter, iteractor: IHomeIteractor) {
        self.router = router
        self.iteractor = iteractor
    }
}

extension HomePresenter: IHomePresenter {
    func viewDidLoad(ui: IHomeView) {
        self.ui = ui
        self.iteractor.getArrayEntity = { array in
            ui.watchlist = array
            ui.configCryptoView()
        }
    }
}
