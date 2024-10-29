//
//  TabBarConfigurator.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class TabBarConfigurator {
    func configure() -> UIViewController {
        let view = TabBarViewController()
        let presenter = TabBarPresenter()
        let interactor = TabbarInteractor()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        setupTabs(for: view)
        
        return view
    }
    
    private func setupTabs(for tabBar: TabBarViewController) {
        tabBar.selectedIndex = 0
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        let newsVC = NewsConfigurator().configure(favoritesManager: FavoritesManager())
        let newsBarItem = UITabBarItem()
        newsBarItem.image = UIImage(systemName: "newspaper.fill")
        newsVC.tabBarItem = newsBarItem
        
        let favoritesVC = FavoritesConfigurator().configure()
        let favoritesBarItem = UITabBarItem()
        favoritesBarItem.image = UIImage(systemName: "star.fill")
        favoritesVC.tabBarItem = favoritesBarItem
        
        tabBar.viewControllers = [
            newsVC,
            favoritesVC
        ]
    }
}
