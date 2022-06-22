//
//  tabBarAssembly.swift
//  MyCryptoProject
//
//  Created by Grekhem on 19.06.2022.
//

import Foundation
import UIKit

enum TabBarAssembly {
    static func buildTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        let networkService = NetworkService()
        let homeController = HomeAssembly.buildModule(networkService: networkService)
        let marketController = MarketAssembly.buildModule()
        let profileController = ProfileAssembly.buildModule()
        
        
        tabBar.setViewControllers([homeController, marketController, profileController], animated: true)
        tabBar.tabBar.tintColor = Color.green.color
        tabBar.tabBar.unselectedItemTintColor = Color.lightGray.color
        
        let homeControllerBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 1)
        homeControllerBarItem.setTitleTextAttributes([.font: AppFonts.mulishSemiBold12.font ?? UIFont.boldSystemFont(ofSize: 12)], for: .normal)
        homeController.tabBarItem = homeControllerBarItem
        homeController.view.layer.backgroundColor = UIColor(white: 1, alpha: 1).cgColor
        
        let marketControllerBarItem = UITabBarItem(title: "Market", image: UIImage(named: "market"), tag: 1)
        marketControllerBarItem.setTitleTextAttributes([.font: AppFonts.mulishSemiBold12.font ?? UIFont.boldSystemFont(ofSize: 12)], for: .normal)
        marketController.tabBarItem = marketControllerBarItem
        marketController.view.layer.backgroundColor = UIColor(white: 1, alpha: 1).cgColor
        
        let profileControllerBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 1)
        profileControllerBarItem.setTitleTextAttributes([.font: AppFonts.mulishSemiBold12.font ?? UIFont.boldSystemFont(ofSize: 12)], for: .normal)
        profileController.tabBarItem = profileControllerBarItem
        profileController.view.layer.backgroundColor = UIColor(white: 1, alpha: 1).cgColor
        
        return tabBar
    }
}
