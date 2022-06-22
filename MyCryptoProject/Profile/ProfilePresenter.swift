//
//  HomePresentor.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation

protocol IProfilePresenter {
    func viewDidLoad(ui: IProfileView)
}

final class ProfilePresenter {
    private weak var ui: IProfileView?
    private var router: IProfileRouter
    private var iteractor: IProfileIteractor
    
    init(router: IProfileRouter, iteractor: IProfileIteractor) {
        self.router = router
        self.iteractor = iteractor
    }
}

extension ProfilePresenter: IProfilePresenter {
    func viewDidLoad(ui: IProfileView) {
        self.ui = ui
    }
}
