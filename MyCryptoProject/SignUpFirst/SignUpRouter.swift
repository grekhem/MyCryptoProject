//
//  SignUpFirstRouter.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import UIKit

protocol ISignUpRouter {
    func openAuthView()
    func registrationEnd()
}

final class SignUpRouter {
    weak var vc: UIViewController?
}

extension SignUpRouter: ISignUpRouter {
    func openAuthView() {
        vc?.dismiss(animated: true, completion: nil)
    }
    
    func registrationEnd() {
        vc?.dismiss(animated: true, completion: nil)
    }
}
