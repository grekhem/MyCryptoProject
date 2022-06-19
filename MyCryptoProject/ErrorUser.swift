//
//  Error.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation

enum ErrorUser {
    case notConfirmPassword
    case invalidPassword
    case notCheck
    
    var text: String {
        switch self {
        case .notConfirmPassword:
            return "Пароли не совпадают"
        case .invalidPassword:
            return "Неправильный пароль"
        case .notCheck:
            return "Необходимо согласиться с условиями"
        }
    }
}
