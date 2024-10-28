//
//  NewsPresenter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class NewsPresenter: NewsOutputProtocol {
    weak var view: NewsViewInputProtocol?
    var interactor: NewsInteractorInputProtocol?
}
