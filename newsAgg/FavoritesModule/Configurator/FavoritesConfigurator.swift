//
//  FavoritesConfigurator.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class FavoritesConfigurator {
    func configure() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
}
