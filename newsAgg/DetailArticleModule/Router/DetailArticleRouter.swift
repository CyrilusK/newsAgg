//
//  DetailArticleRouter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit
import SafariServices

final class DetailArticleRouter: DetailArticleRouterInputProtocol {
    weak var entry: UIViewController?
    
    func dismiss() {
        entry?.dismiss(animated: true)
    }
    
    func presentSafariViewController(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .pageSheet
        entry?.present(safariVC, animated: true)
    }
}

