//
//  FavoritesManager.swift
//  newsAgg
//
//  Created by Cyril Kardash on 29.10.2024.
//

import UIKit

final class FavoritesManager {
    private var favorites: [NewsArticle] = []
    private let storage: FavoritesStorage
    
    init(storage: FavoritesStorage) {
        self.storage = storage
        loadFavorites()
    }
    
    func addFavorite(article: NewsArticle) {
        favorites.append(article)
        saveFavorites()
    }
    
    func removeFavorite(with id: String) {
        favorites.removeAll { $0.article_id == id }
        storage.remove(favoriteArticleID: id)
    }
    
    func getFavorites() -> [NewsArticle] {
        return favorites
    }
    
    func saveFavorites() {
        storage.save(favoriteArticle: favorites)
    }
    
    private func loadFavorites() {
        if let loadedFavorites = storage.load() {
            favorites = loadedFavorites
        }
        else {
            favorites = []
        }
    }
}
