//
//  HomeViewController.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    private var presenter: IProfilePresenter?
    private var customView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = self.customView
        self.presenter?.viewDidLoad(ui: customView)
    }
    
    override func viewWillLayoutSubviews() {
        self.customView.backgroundColor = .darkGray
    }
    
    init(presenter: IProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
