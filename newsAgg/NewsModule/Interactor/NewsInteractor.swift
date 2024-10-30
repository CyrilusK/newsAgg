//
//  NewsInteractor.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsInteractor: NewsInteractorInputProtocol {
    weak var output: NewsOutputProtocol?
    
    func fetchNews(urlString: String = K.urlAPI) async {
        do {
            let news = try await NewsApiManager().fetchNews(urlString: urlString)
            output?.didFetchNews(news)
        }
        catch {
            output?.showError(error)
        }
    }
}
