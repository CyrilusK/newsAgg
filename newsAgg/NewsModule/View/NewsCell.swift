//
//  NewsCell.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsCell: UITableViewCell {
    private let previewImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descripLabel: UILabel = UILabel()
    private let creatorLabel: UILabel = UILabel()
    private let pubDateLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupPreviewImageView()
        setupTitleLabel()
        setupDescripLabel()
        setupCreatorLabel()
        setupPubDateLabel()
        setupStackViews()
    }
    
    private func setupPreviewImageView() {
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.clipsToBounds = true
        previewImageView.layer.cornerRadius = 8
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupDescripLabel() {
        descripLabel.numberOfLines = 0
        descripLabel.font = UIFont.systemFont(ofSize: 12)
        descripLabel.textColor = .gray
    }
    
    private func setupCreatorLabel() {
        creatorLabel.font = UIFont.systemFont(ofSize: 12)
        creatorLabel.textColor = .darkGray
    }
    
    private func setupPubDateLabel() {
        pubDateLabel.font = UIFont.systemFont(ofSize: 12)
        pubDateLabel.textColor = .darkGray
    }
    
    private func setupStackViews() {
        let authorDateStackView = UIStackView(arrangedSubviews: [creatorLabel, pubDateLabel])
        authorDateStackView.axis = .horizontal
        authorDateStackView.distribution = .equalSpacing
        
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, descripLabel, authorDateStackView])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        
        let mainStackView = UIStackView(arrangedSubviews: [previewImageView, textStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.alignment = .top
        
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        previewImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        previewImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }

    func configure(with article: NewsArticle) {
        titleLabel.text = article.title
        creatorLabel.text = article.creator?.joined(separator: ", ") ?? K.unknownCreator
        pubDateLabel.text = article.pubDate
        descripLabel.text = article.description
        
        guard let imageUrl = article.image_url, let imageURL = URL(string: imageUrl) else {
            previewImageView.image = nil
            previewImageView.isHidden = true
            return
        }
        
        previewImageView.isHidden = false
        
        Task {
            do {
                let image = try await ImageLoader().loadImage(from: imageURL)
                DispatchQueue.main.async {
                    self.previewImageView.image = image
                }
            } catch {
                DispatchQueue.main.async {
                    self.previewImageView.image = nil
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView.image = nil
        previewImageView.isHidden = false
    }
}
