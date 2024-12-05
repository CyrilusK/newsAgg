//
//  DetailArticleOutputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol DetailArticleOutputProtocol: AnyObject {
    var isEditable: Bool { get }
    
    func viewDidLoad()
    func dismiss()
    func didTapLink(with url: String?)
    func didFetchImage(_ image: UIImage?)
    func didToggleFavorite()
    func updateFavoriteArctile(title: String?, description: String?)
}
