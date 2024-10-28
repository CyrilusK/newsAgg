//
//  NewsPresenter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsPresenter: NewsOutputProtocol {
    weak var view: NewsViewInputProtocol?
    var interactor: NewsInteractorInputProtocol?
    var router: NewsRouterInputProtocol?
    
    func viewDidLoad() {
        Task(priority: .userInitiated) {
            await interactor?.fetchNews()
            DispatchQueue.main.async {
                self.view?.setupUI()
            }
        }
        view?.setupIndicator()
    }
    
    func didFetchNews(_ news: NewsResponse) {
        DispatchQueue.main.async {
            guard let articles = news.results else {
                return
            }
            self.view?.setNews(articles)
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            if let error = error as? NewsApiError {
                self.view?.displayError("Failed to load videos: \(error.errorDescription)")
            } else {
                self.view?.displayError("Failed to load videos: \(error.localizedDescription)")
            }
        }
    }
    
    func presentNewsDetail(_ article: NewsArticle) {
        router?.presentNewsDetail(article)
    }
}
