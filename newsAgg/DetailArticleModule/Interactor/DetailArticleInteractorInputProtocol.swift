//
//  DetailArticleInteractorInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol DetailArticleInteractorInputProtocol: AnyObject {
    func fetchImage(with url: URL) async
    func getFavoriteArticles() -> [NewsArticle]
    func addFavorite(article: NewsArticle)
    func removeFavorite(with id: String)
    func updateFavorite(article: NewsArticle)
}
