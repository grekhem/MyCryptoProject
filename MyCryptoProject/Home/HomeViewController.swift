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
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.updateData()
    }
    
    override func loadView() {
        self.view = customView
        self.presenter?.viewDidLoad(ui: customView)
        self.presenter?.alert = { [weak self] crypto in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Remove from watchlist", message: "Do you want to remove the \(crypto) from watchlist?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default) { action in
                self.presenter?.removeFromWatchlist(crypto: crypto)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
