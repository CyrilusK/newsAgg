//
//  DetailArticleConfigurator.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class DetailArticleConfigurator {
    func configure(article: NewsArticle, favoritesManager: FavoritesManager, isEditable: Bool) -> UIViewController {
        let view = DetailArticleViewController()
        let presenter = DetailArticlePresenter(article: article, isEditable: isEditable)
        let interactor = DetailArticleInteractor(favoritesManager: favoritesManager)
        let router = DetailArticleRouter()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.entry = view
        
        return view
    }
}
