//
//  DetailArticleViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class DetailArticleViewController: UITableViewController, DetailArticleViewInputProtocol {
    var output: DetailArticleOutputProtocol?
    
    private let scrollView = UIScrollView()
    private var mainStackView = UIStackView()
    private var titleLabel = UILabel()
    private var creatorLabel = UILabel()
    private var datePubLabel = UILabel()
    private var linkLabel = UILabel()
    private var articleImageView = UIImageView()
    private var descTextView = UITextView()
    private let favoriteButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        setupFavoriteButton()
        setupBackButton()
        setupTitleLabel()
        setupCreatorLabel()
        setupDatePubLabel()
        setupArticleImageView()
        setupDescTextView()
        setupLinkLabel()
        setupStackView()
    }
    
    private func setupFavoriteButton() {
        favoriteButton.tintColor = .orange
        favoriteButton.setImage(UIImage(systemName: K.bookmark), for: .normal)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
    
    private func setupBackButton() {
        backButton.tintColor = .orange
        backButton.setImage(UIImage(systemName: K.back), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
    }
    
    private func setupCreatorLabel() {
        creatorLabel.font = UIFont.systemFont(ofSize: 14)
        creatorLabel.textColor = .darkGray
    }
    
    private func setupDatePubLabel() {
        datePubLabel.font = UIFont.systemFont(ofSize: 14)
        datePubLabel.textColor = .darkGray
    }
    
    private func setupLinkLabel() {
        linkLabel.font = UIFont.systemFont(ofSize: 14)
        linkLabel.textColor = .systemBlue
        linkLabel.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        linkLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupArticleImageView() {
        articleImageView.contentMode = .scaleAspectFit
        articleImageView.clipsToBounds = true
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDescTextView() {
        descTextView.backgroundColor = .systemGroupedBackground
        descTextView.font = UIFont.systemFont(ofSize: 16)
        descTextView.isEditable = false
        descTextView.isScrollEnabled = false
        descTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(creatorLabel)
        mainStackView.addArrangedSubview(datePubLabel)
        mainStackView.addArrangedSubview(articleImageView)
        mainStackView.addArrangedSubview(descTextView)
        mainStackView.addArrangedSubview(linkLabel)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            articleImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setArticleDetails(_ article: NewsArticle, _ image: UIImage?) {
        titleLabel.text = article.title
        creatorLabel.text = article.creator?.joined(separator: ", ") ?? K.unknownCreator
        datePubLabel.text = article.pubDate
        descTextView.text = article.description ?? K.noDescription
        linkLabel.text = article.link
        guard let image = image else {
            articleImageView.isHidden = true
            return
        }
        articleImageView.image = image
    }
    
    @objc private func toggleFavorite() {
        output?.didToggleFavorite()
    }
    
    @objc private func backButtonTapped() {
        output?.dismiss()
    }
    
    @objc private func linkTapped() {
        output?.didTapLink(with: linkLabel.text)
    }
    
    func setImageFavorite(_ flag: Bool) {
        let imageName = flag ? K.bookmarkFill : K.bookmark
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
