//
//  TabBarPresenter.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class TabBarPresenter: TabBarOutputProtocol {
    weak var view: TabBarViewInputProtocol?
    var interactor: TabBarInteractorInputProtocol?
}
