//
//  NewsCell.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsCell: UITableViewCell {
    private var imageViewWidthConstraint: NSLayoutConstraint?
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let descripLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let creatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let pubDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
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
            previewImageView.isHidden = true
            return
        }
        
        previewImageView.isHidden = false
        imageViewWidthConstraint?.isActive = true
        
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
