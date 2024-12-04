//
//  FavoritesInteractorInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol FavoritesInteractorInputProtocol: AnyObject {
    func getFavoriteManager() -> FavoritesManager
    func getFavoriteArticles() -> [NewsArticle]
    func removeFavorite(with id: String)
}
