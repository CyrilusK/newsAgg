//
//  NewsViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsViewController: UIViewController, NewsViewInputProtocol {
    var output: NewsOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
    }
}
