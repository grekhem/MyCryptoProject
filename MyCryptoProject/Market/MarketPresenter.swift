//
//  HomePresentor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation

protocol IMarketPresenter {
    func viewDidLoad(ui: IMarketView)
}

final class MarketPresenter {
    private weak var ui: IMarketView?
    private var router: IMarketRouter
    private var iteractor: IMarketIteractor
    
    init(router: IMarketRouter, iteractor: IMarketIteractor) {
        self.router = router
        self.iteractor = iteractor
    }
}

extension MarketPresenter: IMarketPresenter {
    func viewDidLoad(ui: IMarketView) {
        self.ui = ui
    }
}
