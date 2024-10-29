//
//  DetailArticleOutputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol DetailArticleOutputProtocol: AnyObject {
    func viewDidLoad()
    func dismiss()
    func didTapLink(with url: String?)
    func didFetchImage(_ image: UIImage?)
    func didToggleFavorite()
}
