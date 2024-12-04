//
//  FavoriteArticle.swift
//  newsAgg
//
//  Created by Cyril Kardash on 05.12.2024.
//

import UIKit
import RealmSwift

class FavoriteArticle: Object {
    @Persisted(primaryKey: true) var articleID: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var creator: List<String>
    @Persisted var imageURL: String
    @Persisted var descriptionText: String
    @Persisted var pubDate: String
    @Persisted var content: String
    
    convenience init(from article: NewsArticle) {
        self.init()
        self.articleID = article.article_id ?? UUID().uuidString
        self.title = article.title ?? ""
        self.link = article.link ?? ""
        self.creator.append(objectsIn: article.creator ?? [K.unknownCreator])
        self.imageURL = article.image_url ?? ""
        self.descriptionText = article.description ?? ""
        self.pubDate = article.pubDate ?? ""
        self.content = article.content ?? ""
    }
}

