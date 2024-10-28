//
//  NewsOutputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol NewsOutputProtocol: AnyObject {
    func viewDidLoad()
    func didFetchNews(_ news: NewsResponse)
    func showError(_ error: Error)
    func presentNewsDetail(_ article: NewsArticle)
}
