//
//  AppFonts.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import Foundation
import UIKit

enum AppFonts {
    case montserratMedium14
    case mulishSemiBold14
    case mulishBold32
    case mulishBold20
    case mulishBold16
    case mulishBold10
    case mulishSemiBold16
    case mulishBold24
    case mulishSemiBold12
    case mulishRegular16
    case mulishRegular14
    case mulishRegular12
    
    var font: UIFont? {
        switch self {
        case .montserratMedium14:
            return UIFont(name: "Montserrat-Medium", size: 14)
        case .mulishSemiBold14:
            return UIFont(name: "Mulish-SemiBold", size: 14)
        case .mulishBold32:
            return UIFont(name: "Mulish-Bold", size: 32)
        case .mulishSemiBold12:
            return UIFont(name: "Mulish-SemiBold", size: 12)
        case .mulishBold20:
            return UIFont(name: "Mulish-Bold", size: 20)
        case .mulishRegular16:
            return UIFont(name: "Mulish-Regular", size: 16)
        case .mulishBold16:
            return UIFont(name: "Mulish-Bold", size: 16)
        case .mulishBold10:
            return UIFont(name: "Mulish-Bold", size: 10)
        case .mulishRegular14:
            return UIFont(name: "Mulish-Regular", size: 14)
        case .mulishBold24:
            return UIFont(name: "Mulish-Bold", size: 24)
        case .mulishRegular12:
            return UIFont(name: "Mulish-Regular", size: 12)
        case .mulishSemiBold16:
            return UIFont(name: "Mulish-SemiBold", size: 16)
        }
    }
}
