//
//  FavoritesPresenter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class FavoritesPresenter: FavoritesOutputProtocol {
    weak var view: FavoritesViewInputProtocol?
    var interactor: FavoritesInteractorInputProtocol?
    var router: NewsRouterInputProtocol?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesUpdated, object: nil)
    }
    
    func viewDidLoad() {
        view?.setupUI()
        loadFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoritesUpdated), name: .favoritesUpdated, object: nil)
    }
    
    func presentNewsDetail(_ article: NewsArticle) {
        guard let favoriteManager = interactor?.getFavoriteManager() else {
            return
        }
        router?.presentNewsDetail(article, favoriteManager)
    }
    
    private func loadFavorites() {
        guard let news = interactor?.getFavoriteArticles() else { return }
        view?.setNews(news)
    }
    
    @objc private func handleFavoritesUpdated() {
        loadFavorites()
    }
}
