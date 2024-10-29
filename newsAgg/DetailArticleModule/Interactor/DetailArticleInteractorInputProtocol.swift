//
//  DetailArticleInteractorInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol DetailArticleInteractorInputProtocol: AnyObject {
    func fetchImage(with url: URL) async
}
