//
//  NewsRouter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsRouter: NewsRouterInputProtocol {
    weak var entry: UIViewController?
    
    func presentNewsDetail(_ article: NewsArticle) {
        print(article)
//        let detailVC = SelectedNewsConfigurator().configure()
//        let navController = UINavigationController(rootViewController: detailVC)
//        navController.modalPresentationStyle = .fullScreen
//        entry?.present(detailVC, animated: true)
    }
}
