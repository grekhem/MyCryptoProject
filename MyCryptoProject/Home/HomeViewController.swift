//
//  HomeViewController.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    
    private var presenter: IHomePresenter?
    private var customView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = customView
        self.presenter?.viewDidLoad(ui: customView)
    }
    
    override func viewDidLayoutSubviews() {
        self.customView.backgroundColor = Color.gray.color
    }
    
    init(presenter: IHomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
