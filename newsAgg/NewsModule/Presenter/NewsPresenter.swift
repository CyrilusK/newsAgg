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
    
    private let favoritesManager: FavoritesManager
    private var response: NewsResponse? = nil
    private var isLoading = false
    private var isRefreshing = false
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }
    
    func viewDidLoad() {
        fetchInitialNews()
        view?.setupIndicator()
    }
    
    private func fetchInitialNews() {
        isLoading = true
        Task(priority: .userInitiated) {
            await interactor?.fetchNews(urlString: K.urlAPI)
            DispatchQueue.main.async {
                self.view?.setupUI()
            }
        }
    }
    
    func refreshNews() {
        isRefreshing = true
        Task(priority: .userInitiated) {
            await interactor?.fetchNews(urlString: K.urlAPI)
        }
    }
    
    func didFetchNews(_ news: NewsResponse) {
        DispatchQueue.main.async {
            self.isLoading = false
            guard let articles = news.results else {
                return
            }
            if self.response == nil || self.isRefreshing {
                self.view?.setNews(articles)
            } else {
                self.view?.appendNews(articles)
            }
            self.response = news
            self.isRefreshing = false
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.isRefreshing = false
            if let error = error as? NewsApiError {
                self.view?.displayError("Failed to load news: \(error.errorDescription)")
            } else {
                self.view?.displayError("Failed to load news: \(error.localizedDescription)")
            }
        }
    }
    
    func presentNewsDetail(_ article: NewsArticle) {
        router?.presentNewsDetail(article, favoritesManager, false)
    }
    
    func pagination() {
        guard !isLoading, let nextPage = response?.nextPage else { return }
        
        isLoading = true
        Task(priority: .userInitiated) {
            await interactor?.fetchNews(urlString: K.urlAPI + K.page + nextPage)
        }
    }
}
