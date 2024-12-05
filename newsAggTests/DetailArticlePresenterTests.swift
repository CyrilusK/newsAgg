//
//  DetailArticlePresenterTests.swift
//  newsAggTests
//
//  Created by Cyril Kardash on 05.12.2024.
//

import XCTest
@testable import newsAgg

final class DetailArticlePresenterTests: XCTestCase {
    var presenter: DetailArticlePresenter!
    var mockInteractor: MockDetailArticleInteractor!
    var mockView: MockDetailArticleView!
    var mockRouter: MockDetailArticleRouter!
    
    override func setUp() {
        super.setUp()
        let article = NewsArticle(
            article_id: "1",
            title: "title",
            link: "url",
            creator: ["author"],
            image_url: nil,
            description: nil,
            pubDate: "12/12/2024",
            content: "img")
        
        presenter = DetailArticlePresenter(article: article, isEditable: true)
        mockInteractor = MockDetailArticleInteractor()
        mockView = MockDetailArticleView()
        mockRouter = MockDetailArticleRouter()
        
        presenter.interactor = mockInteractor
        presenter.view = mockView
        presenter.router = mockRouter
    }

    func testViewDidLoad() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockView.setupUICalled)
    }
    
    func testDismiss() {
        presenter.dismiss()
        XCTAssertTrue(mockRouter.dismissCalled)
    }
    
    func testDidTapLink() {
        presenter.didTapLink(with: "Test")
        XCTAssertTrue(mockRouter.presentSafariCalled)
    }
    
    func testDidFetchImage() {
        presenter.didFetchImage(UIImage())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockView.setArticleDetailsCalled)
        }
    }
    
    func testDidToggleFavorite() {
        presenter.didToggleFavorite()
        XCTAssertTrue(mockInteractor.addFavoriteCalled)
        XCTAssertTrue(mockView.setImageFavoriteCalled)
    }
}

final class MockDetailArticleInteractor: DetailArticleInteractorInputProtocol {
    var fetchImageCalled = false
    var addFavoriteCalled = false
    var removeFavoriteCalled = false
    
    func fetchImage(with url: URL) async {
        fetchImageCalled = true
    }
    
    func getFavoriteArticles() -> [newsAgg.NewsArticle] {
        []
    }
    
    func addFavorite(article: newsAgg.NewsArticle) {
        addFavoriteCalled = true
    }
    
    func removeFavorite(with id: String) {
        removeFavoriteCalled = true
    }
    
    func updateFavorite(article: newsAgg.NewsArticle) {}
}

final class MockDetailArticleView: DetailArticleViewInputProtocol {
    var setupUICalled = false
    var setArticleDetailsCalled = false
    var setImageFavoriteCalled = false
    
    func setupUI() {
        setupUICalled = true
    }
    
    func setArticleDetails(_ article: newsAgg.NewsArticle, _ image: UIImage?) {
        setArticleDetailsCalled = true
    }
    
    func setImageFavorite(_ imageName: String) {
        setImageFavoriteCalled = true
    }
}

final class MockDetailArticleRouter: DetailArticleRouterInputProtocol {
    var dismissCalled = false
    var presentSafariCalled = false
    
    func dismiss() {
        dismissCalled = true
    }
    
    func presentSafariViewController(with url: URL) {
        presentSafariCalled = true
    }
}
