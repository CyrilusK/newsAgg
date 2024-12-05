//
//  NewsRouter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsRouter: NewsRouterInputProtocol {
    weak var entry: UIViewController?
    
    func presentNewsDetail(_ article: NewsArticle, _ favoritesManager: FavoritesManager, _ isEditable: Bool) {
        let detailVC = DetailArticleConfigurator().configure(article: article, favoritesManager: favoritesManager, isEditable: isEditable)
        let navController = UINavigationController(rootViewController: detailVC)
        navController.modalPresentationStyle = .fullScreen
        entry?.present(navController, animated: true)
    }
}
