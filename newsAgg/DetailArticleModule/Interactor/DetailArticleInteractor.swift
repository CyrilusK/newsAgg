//
//  DetailArticleInteractor.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class DetailArticleInteractor: DetailArticleInteractorInputProtocol {
    weak var output: DetailArticleOutputProtocol?
    
    func fetchImage(with url: URL) async {
        do {
            let image = try await ImageLoader().loadImage(from: url)
            self.output?.didFetchImage(image)
        }
        catch {
            self.output?.didFetchImage(nil)
        }
    }
}
