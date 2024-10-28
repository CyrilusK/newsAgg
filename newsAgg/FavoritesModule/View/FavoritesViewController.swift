//
//  FavoritesViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class FavoritesViewController: UIViewController, FavoritesViewInputProtocol {
    var output: FavoritesOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = K.favorites
    }
}
