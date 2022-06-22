//
//  HomeView.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

protocol IProfileView: AnyObject {
    
}

final class ProfileView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileView: IProfileView {
    
}
