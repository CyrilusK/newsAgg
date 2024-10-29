//
//  FavoritesManager.swift
//  newsAgg
//
//  Created by Cyril Kardash on 29.10.2024.
//

import UIKit

final class FavoritesManager {
    private var favorites: [NewsArticle] = []
    private let fileManager = FileManager()
    
    init() {
        loadFavorites()
    }
    
    func addFavorite(article: NewsArticle) {
        favorites.append(article)
        saveFavorites()
    }
    
    func removeFavorite(with id: String) {
        favorites.removeAll { $0.article_id == id }
        saveFavorites()
    }
    
    func getFavorites() -> [NewsArticle] {
        return favorites
    }
    
    func saveFavorites() {
        fileManager.saveFavoriteToFile(favoriteArticle: favorites)
    }
    
    private func loadFavorites() {
        if let loadedFavorites = fileManager.loadFavoriteFromFile() {
            favorites = loadedFavorites
        }
        else {
            favorites = []
        }
    }
}
