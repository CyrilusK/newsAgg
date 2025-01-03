//
//  DetailArticlePresenter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class DetailArticlePresenter: DetailArticleOutputProtocol {
    weak var view: DetailArticleViewInputProtocol?
    var interactor: DetailArticleInteractorInputProtocol?
    var router: DetailArticleRouterInputProtocol?
 
    private var article: NewsArticle
    private var isFavorite = false
    var isEditable = false
    
    init(article: NewsArticle, isEditable: Bool) {
        self.article = article
        self.isEditable = isEditable
    }
    
    func viewDidLoad() {
        view?.setupUI()
        
        updateFavoriteStatus()
        
        guard let imageUrl = article.image_url, let imageURL = URL(string: imageUrl) else {
            view?.setArticleDetails(self.article, nil)
            return
        }
        Task(priority: .userInitiated) {
            await interactor?.fetchImage(with: imageURL)
        }
    }
    
    func dismiss() {
        router?.dismiss()
    }
    
    func didTapLink(with url: String?) {
        guard let urlString = url, let url = URL(string: urlString) else { return }
        router?.presentSafariViewController(with: url)
    }
    
    func didFetchImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.view?.setArticleDetails(self.article, image)
        }
    }
    
    func didToggleFavorite() {
        isFavorite.toggle()
        
        if isFavorite {
            interactor?.addFavorite(article: article)
            view?.setImageFavorite(K.bookmarkFill)
        } else {
            interactor?.removeFavorite(with: article.article_id ?? "")
            view?.setImageFavorite(K.bookmark)
        }
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }
    
    private func updateFavoriteStatus() {
        let favorites = interactor?.getFavoriteArticles() ?? []
        isFavorite = favorites.contains { $0.article_id == article.article_id }
        view?.setImageFavorite(isFavorite ? K.bookmarkFill : K.bookmark)
    }
    
    func updateFavoriteArctile(title: String?, description: String?) {
        article.title = title
        article.description = description
        interactor?.updateFavorite(article: article)
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }
}
