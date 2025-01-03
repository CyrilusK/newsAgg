//
//  NewsViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsViewController: UIViewController, NewsViewInputProtocol {
    var output: NewsOutputProtocol?
    
    private var news: [NewsArticle] = []
    private let indicatorLoading = UIActivityIndicatorView(style: .medium)
    private let refreshNews = UIRefreshControl()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI() {
        indicatorLoading.stopAnimating()
        refreshNews.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshNews
        setupTableView()
    }
    
    func setNews(_ news: [NewsArticle]) {
        self.news = news
        tableView.reloadData()
        refreshNews.endRefreshing()
    }
    
    func appendNews(_ newNews: [NewsArticle]) {
        let startIndex = news.count
        news.append(contentsOf: newNews)
        let indexPaths = (startIndex..<news.count).map { IndexPath(row: $0, section: 0) }
        tableView.insertRows(at: indexPaths, with: .automatic)
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
    }
    
    @objc private func refreshTableView() {
        output?.refreshNews()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height {
            output?.pagination()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: K.newsCell)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.newsCell, for: indexPath) as! NewsCell
        let article = news[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.presentNewsDetail(news[indexPath.row])
    }
}
