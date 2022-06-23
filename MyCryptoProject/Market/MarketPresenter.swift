//
//  HomePresentor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation

protocol IMarketPresenter {
    func viewDidLoad(ui: IMarketView)
    var alert: ((String) -> Void)? { get set }
}

final class MarketPresenter {
    var alert: ((String) -> Void)?
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
        self.iteractor.getArrayEntity = { array in
            ui.setData(crypto: array)
        }
        self.ui?.addWatchlist = { [weak self] crypto in
            guard let self = self else { return }
            self.iteractor.addWatchlist(crypto: crypto)
        }
        self.iteractor.getWatchlist = { [weak self] watchlist in
            self?.ui?.watchlist = watchlist
        }
        ui.addAlert = { [weak self] alert in
            guard let self = self else { return }
            self.alert?(alert)
        }
    }
}
