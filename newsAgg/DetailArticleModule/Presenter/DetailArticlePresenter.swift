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
    
    init(article: NewsArticle) {
        self.article = article
    }
    
    func viewDidLoad() {
        view?.setupUI()
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
        view?.setImageFavorite(isFavorite)
    }
}
