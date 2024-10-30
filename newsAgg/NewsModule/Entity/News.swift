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
}
