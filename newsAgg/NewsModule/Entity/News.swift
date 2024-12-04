//
//  News.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

struct NewsResponse: Decodable {
    let results: [NewsArticle]?
    let nextPage: String?
}

struct NewsArticle: Codable {
    let article_id: String?
    let title: String?
    let link: String?
    let creator: [String]?
    let image_url: String?
    let description: String?
    let pubDate: String?
    let content: String?
    
    init(article_id: String?, title: String?, link: String?, creator: [String]?, image_url: String?, description: String?, pubDate: String?, content: String?) {
        self.article_id = article_id
        self.title = title
        self.link = link
        self.creator = creator
        self.image_url = image_url
        self.description = description
        self.pubDate = pubDate
        self.content = content
    }
    
    init(from favorite: FavoriteArticle) {
        self.init(
            article_id: favorite.articleID,
            title: favorite.title,
            link: favorite.link,
            creator: Array(favorite.creator),
            image_url: favorite.imageURL,
            description: favorite.descriptionText,
            pubDate: favorite.pubDate,
            content: favorite.content
        )
    }
}
