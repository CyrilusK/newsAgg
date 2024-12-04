//
//  FavoritesViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class FavoritesViewController: UIViewController, FavoritesViewInputProtocol {
    var output: FavoritesOutputProtocol?
    
    private let tableView = UITableView()
    private var news: [NewsArticle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI() {
        tableView.backgroundColor = .systemGroupedBackground
        title = K.favorites
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: K.newsCell)
    }
    
    func setNews(_ news: [NewsArticle]) {
        self.news = news.reversed()
        tableView.reloadData()
    }
    
    @objc private func refreshTableView() {
        output?.viewDidLoad()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: K.deleteAction) { [weak self] _, _, complete in
            guard let self = self else { return }
            let newForDelete = news[indexPath.row]
            news.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            output?.didSwipeToDelete(newForDelete.article_id ?? "")
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
