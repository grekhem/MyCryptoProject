//
//  AuthorizationRouter.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import Foundation
import UIKit

protocol IAuthorizationRouter: AnyObject {
    func openSignUpView()
    func openApp()
}

final class AuthorizationRouter {
    weak var vc: UIViewController?
}

extension AuthorizationRouter: IAuthorizationRouter {
    func openSignUpView() {
        let nextVC = SignUpAssembly.buildModule()
        nextVC.modalPresentationStyle = .fullScreen
        vc?.present(nextVC, animated: true, completion: nil)
    }
    
    func openApp() {
        let nextVc = HomeViewController()
        nextVc.modalTransitionStyle = .flipHorizontal
        nextVc.modalPresentationStyle = .fullScreen
        vc?.present(nextVc, animated: true, completion: nil)
    }
}
