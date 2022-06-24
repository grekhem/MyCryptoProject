//
//  underLineButton.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

final class UnderLineButton: UIButton {
    
    init(text: String, length: Int, locationLine: Int, lengthLine: Int) {
        super.init(frame: .zero)
        let underlineRange = NSRange(location: locationLine, length: lengthLine)
        let range = NSRange(location: 0, length: length)
        let string = text
        let attribute = NSMutableAttributedString.init(string: string)
        attribute.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: underlineRange)
        attribute.addAttributes([NSAttributedString.Key.foregroundColor: Color.green.color], range: range)
        attribute.addAttributes([NSAttributedString.Key.font : AppFonts.mulishSemiBold12.font as Any], range: range)
        self.setAttributedTitle(attribute, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
