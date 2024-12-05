//
//  NewsRouterInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol NewsRouterInputProtocol {
    func presentNewsDetail(_ article: NewsArticle, _ favoritesManager: FavoritesManager, _ isEditable: Bool)
}
