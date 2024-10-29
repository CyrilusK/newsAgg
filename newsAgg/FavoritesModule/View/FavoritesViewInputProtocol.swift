//
//  FavoritesViewInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol FavoritesViewInputProtocol: AnyObject {
    func setupUI()
    func setNews(_ news: [NewsArticle])
}

