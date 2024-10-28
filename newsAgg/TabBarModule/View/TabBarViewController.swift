//
//  TabBarViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class TabBarViewController: UITabBarController, TabBarViewInputProtocol {
    var output: TabBarOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .orange
    }
}
