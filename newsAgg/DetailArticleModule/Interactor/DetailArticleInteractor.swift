//
//  DetailArticleInteractor.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class DetailArticleInteractor: DetailArticleInteractorInputProtocol {
    weak var output: DetailArticleOutputProtocol?
    
    private let favoritesManager: FavoritesManager
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }
    
    func fetchImage(with url: URL) async {
        do {
            let image = try await ImageLoader().loadImage(from: url)
            self.output?.didFetchImage(image)
        }
        catch {
            self.output?.didFetchImage(nil)
        }
    }
    
    func getFavoriteArticles() -> [NewsArticle] {
        favoritesManager.getFavorites()
    }
    
    func addFavorite(article: NewsArticle) {
        favoritesManager.addFavorite(article: article)
    }
    
    func removeFavorite(with id: String) {
        favoritesManager.removeFavorite(with: id)
    }
}
