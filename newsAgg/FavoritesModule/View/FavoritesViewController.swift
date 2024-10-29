//
//  FavoritesViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class FavoritesViewController: UITableViewController, FavoritesViewInputProtocol {
    var output: FavoritesOutputProtocol?
    
    private var news: [NewsArticle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI() {
        tableView.backgroundColor = .systemGroupedBackground
        title = K.favorites
        tableView.register(NewsCell.self, forCellReuseIdentifier: K.newsCell)
    }
    
    func setNews(_ news: [NewsArticle]) {
        self.news = news.reversed()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.newsCell, for: indexPath) as! NewsCell
        let article = news[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    @objc private func refreshTableView() {
        output?.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.presentNewsDetail(news[indexPath.row])
    }
}
