//
//  FavoritesInteractor.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class FavoritesInteractor: FavoritesInteractorInputProtocol {
    weak var output: FavoritesOutputProtocol?
    
    private let favoritesManager: FavoritesManager
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }
    
    func getFavoriteManager() -> FavoritesManager {
        favoritesManager
    }
    
    func getFavoriteArticles() -> [NewsArticle] {
        favoritesManager.getFavorites()
    }
    
    func removeFavorite(with id: String) {
        favoritesManager.removeFavorite(with: id)
    }
}
