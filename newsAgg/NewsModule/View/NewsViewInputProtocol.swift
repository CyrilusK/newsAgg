//
//  NewsViewInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol NewsViewInputProtocol: AnyObject {
    func setupUI()
    func displayError(_ message: String)
    func setupIndicator()
    func setNews(_ news: [NewsArticle])
    func appendNews(_ newNews: [NewsArticle])
}
