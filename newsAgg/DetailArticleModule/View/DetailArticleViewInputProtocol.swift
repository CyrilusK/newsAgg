//
//  DetailArticleViewInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol DetailArticleViewInputProtocol: AnyObject {
    func setupUI()
    func setArticleDetails(_ article: NewsArticle, _ image: UIImage?)
    func setImageFavorite(_ imageName: String)
}
