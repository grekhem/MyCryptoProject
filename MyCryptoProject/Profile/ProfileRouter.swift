//
//  HomeRouter.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

protocol IProfileRouter {
    func logOut()
}

final class ProfileRouter {
    weak var vc: UIViewController?
    weak var tabbar: UITabBarController?
}

extension ProfileRouter: IProfileRouter {
    func logOut() {
        self.tabbar?.dismiss(animated: true, completion: nil)
    }
}
