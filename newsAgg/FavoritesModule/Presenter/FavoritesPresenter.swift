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
}
