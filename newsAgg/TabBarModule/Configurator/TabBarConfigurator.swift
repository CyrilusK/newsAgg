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
        setupTabs(for: view)
        return view
    }
    
    private func setupTabs(for tabBar: TabBarViewController) {
        tabBar.selectedIndex = 0
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        let favoritesManager = FavoritesManager(storage: FileManager())
        let newsVC = NewsConfigurator().configure(favoritesManager: favoritesManager)
        let newsBarItem = UITabBarItem()
        newsBarItem.image = UIImage(systemName: K.newspaperFill)
        newsVC.tabBarItem = newsBarItem
        
        let favoritesVC = FavoritesConfigurator().configure(favoritesManager: favoritesManager)
        let favoritesBarItem = UITabBarItem()
        favoritesBarItem.image = UIImage(systemName: K.bookmarkFill)
        favoritesVC.tabBarItem = favoritesBarItem
        
        tabBar.viewControllers = [
            newsVC,
            favoritesVC
        ]
    }
}
