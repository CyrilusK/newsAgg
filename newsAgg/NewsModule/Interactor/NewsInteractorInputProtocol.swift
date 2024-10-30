//
//  NewsInteractorInputProtocol.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

protocol NewsInteractorInputProtocol: AnyObject {
    func fetchNews(urlString: String) async
}
