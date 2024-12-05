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
    private let mainStackView = UIStackView()
    private let titleTextView = UITextView()
    private let creatorLabel = UILabel()
    private let datePubLabel = UILabel()
    private let linkLabel = UILabel()
    private let articleImageView = UIImageView()
    private let descTextView = UITextView()
    private let favoriteButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let _ = output?.isEditable else { return }
        output?.updateFavoriteArctile(title: titleTextView.text, description: descTextView.text)
    }
    
    func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        setupFavoriteButton()
        setupBackButton()
        setupTitleTextView()
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
    
    private func setupTitleTextView() {
        titleTextView.backgroundColor = .systemGroupedBackground
        titleTextView.font = UIFont.boldSystemFont(ofSize: 20)
        titleTextView.autocorrectionType = .default
        titleTextView.textContainer.maximumNumberOfLines = 5
        titleTextView.textContainer.lineBreakMode = .byTruncatingTail
        titleTextView.isScrollEnabled = false
        titleTextView.isEditable = output?.isEditable ?? false
        titleTextView.delegate = self
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
    }
    
    private func setupDescTextView() {
        descTextView.backgroundColor = .systemGroupedBackground
        descTextView.font = UIFont.systemFont(ofSize: 16)
        descTextView.isEditable = output?.isEditable ?? false
        descTextView.isScrollEnabled = false
        descTextView.delegate = self
    }
    
    private func setupStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.addArrangedSubview(titleTextView)
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
        titleTextView.text = article.title
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
    
    func setImageFavorite(_ imageName: String) {
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

extension DetailArticleViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
