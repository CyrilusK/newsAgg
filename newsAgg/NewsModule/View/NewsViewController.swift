//
//  NewsViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsViewController: UITableViewController, NewsViewInputProtocol {
    var output: NewsOutputProtocol?
    private var news: [NewsArticle] = []
    private let indicatorLoading = UIActivityIndicatorView(style: .medium)
    private let refreshNews = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI() {
        indicatorLoading.stopAnimating()
        refreshNews.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshNews
    }
    
    func setNews(_ news: [NewsArticle]) {
        self.news = news
        tableView.reloadData()
        refreshNews.endRefreshing()
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: K.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: K.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        refreshNews.endRefreshing()
    }
    
    func setupIndicator() {
        tableView.backgroundColor = .systemGroupedBackground
        title = K.news
        indicatorLoading.translatesAutoresizingMaskIntoConstraints = false
        indicatorLoading.startAnimating()
        view.addSubview(indicatorLoading)
        indicatorLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.register(NewsCell.self, forCellReuseIdentifier: K.newsCell)
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
