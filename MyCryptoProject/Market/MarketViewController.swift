//
//  HomeViewController.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

final class MarketViewController: UIViewController {
    
    private var presenter: IMarketPresenter?
    private var customView = MarketView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = self.customView
        self.presenter?.viewDidLoad(ui: customView)
        self.presenter?.alert = { [weak self] alert in
            guard let self = self else { return }
            self.alertAdd(alert: alert)
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.customView.backgroundColor = Color.gray.color
    }
    
    init(presenter: IMarketPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MarketViewController {
    func alertAdd(alert: String) {
        let alert = UIAlertController(title: "Add to watchlist", message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
