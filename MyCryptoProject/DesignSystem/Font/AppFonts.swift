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
    case mulishSemiBold12
    
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
        }
    }
}
