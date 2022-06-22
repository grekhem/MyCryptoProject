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
    
    private func greeting() -> String {
        let date = Date.now
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        switch hour {
        case 5..<12:
            return "Good morning,"
        case 12..<18:
            return "Good afternoon,"
        default:
            return "Good evening,"
        }
    }
}

extension HomePresenter: IHomePresenter {
    func viewDidLoad(ui: IHomeView) {
        self.ui = ui
        ui.updateGreeting(greeting: self.greeting())
        self.iteractor.getArrayEntity = { array in
            ui.watchlist = array
            ui.configCryptoView()
        }
        self.iteractor.getUserInfo = { [weak self] user in
            guard let self = self else { return }
            self.ui?.user = user
            self.ui?.updatePhoto()
            self.ui?.updateName()
        }
    }
}