//
//  NewsConfigurator.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsConfigurator {
    func configure(favoritesManager: FavoritesManager) -> UIViewController {
        let view = NewsViewController()
        let presenter = NewsPresenter(favoritesManager: favoritesManager)
        let interactor = NewsInteractor()
        let router = NewsRouter()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.entry = view
        
        return view
    }
}
