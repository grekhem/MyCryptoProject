//
//  GreenButton.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

final class GreenButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = Color.green.color
        self.layer.cornerRadius = Constants.enterButtonRadius
        self.titleLabel?.font = AppFonts.mulishSemiBold12.font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
