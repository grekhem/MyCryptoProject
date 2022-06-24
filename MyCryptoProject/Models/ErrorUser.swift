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
            return "Password do not match"
        case .invalidPassword:
            return "Wrong password"
        case .notCheck:
            return "You will need to read and accept the Terms and conditions"
        }
    }
}
