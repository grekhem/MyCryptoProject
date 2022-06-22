//
//  Color.swift
//  MyCryptoProject
//
//  Created by Grekhem on 18.06.2022.
//

import Foundation
import UIKit
import SwiftUI

enum Color {
    case green
    case gray
    case lightGreen
    case yellow
    case blue
    case lightGray
    case darkGreen
    case red
    
    var color: UIColor {
        switch self {
        case .green:
            return UIColor(red: 94/255, green: 222/255, blue: 153/255, alpha: 1)
        case .gray:
            return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        case .lightGreen:
            return UIColor(red: 233/255, green: 252/255, blue: 233/255, alpha: 1)
        case .yellow:
            return UIColor(red: 239/255, green: 190/255, blue: 36/255, alpha: 1)
        case .blue:
            return UIColor(red: 30/255, green: 130/255, blue: 197/255, alpha: 1)
        case .lightGray:
            return UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        case .darkGreen:
            return UIColor(red: 21/255, green: 44/255, blue: 7/255, alpha: 1)
        case .red:
            return UIColor(red: 242/255, green: 102/255, blue: 102/255, alpha: 1)
        }
    }
}
