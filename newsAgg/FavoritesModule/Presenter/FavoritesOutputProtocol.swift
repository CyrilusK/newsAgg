//
//  FavoritesOutputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol FavoritesOutputProtocol: AnyObject {
    func viewDidLoad()
    func presentNewsDetail(_ article: NewsArticle)
    func didSwipeToDelete(_ id: String)
}
