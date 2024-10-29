//
//  DetailArticleConfigurator.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class DetailArticleConfigurator {
    func configure(article: NewsArticle) -> UIViewController {
        let view = DetailArticleViewController()
        let presenter = DetailArticlePresenter(article: article)
        let interactor = DetailArticleInteractor()
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
