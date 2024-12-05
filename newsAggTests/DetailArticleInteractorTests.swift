//
//  DetailArticleInteractorTests.swift
//  newsAggTests
//
//  Created by Cyril Kardash on 05.12.2024.
//


import XCTest
@testable import newsAgg

final class DetailArticleInteractorTests: XCTestCase {
    var interactor: DetailArticleInteractor!
    var mockFavoritesManager: MockFavoritesManager!
    var mockOutput: MockDetailArticleOutput!

    override func setUp() {
        super.setUp()
        mockFavoritesManager = MockFavoritesManager(storage: RealmStorage())
        mockOutput = MockDetailArticleOutput()
        interactor = DetailArticleInteractor(favoritesManager: mockFavoritesManager)
        interactor.output = mockOutput
    }

    override func tearDown() {
        interactor = nil
        mockFavoritesManager = nil
        mockOutput = nil
        super.tearDown()
    }

    func testFetchImage() async {
        let imageURL = URL(string: "https://example.com/image.png")!
        let mockImage = UIImage(systemName: "star")

        await interactor.fetchImage(with: imageURL)

        XCTAssertTrue(mockOutput.didFetchImageCalled)
    }

    func testGetFavoriteArticles() {
        let mockArticles = [
            NewsArticle(article_id: "1", title: "Title 1", link: nil, creator: nil, image_url: nil, description: nil, pubDate: nil, content: nil),
            NewsArticle(article_id: "2", title: "Title 2", link: nil, creator: nil, image_url: nil, description: nil, pubDate: nil, content: nil)
        ]
        mockFavoritesManager.mockFavorites = mockArticles

        let favorites = interactor.getFavoriteArticles()

        XCTAssertEqual(favorites.count, mockArticles.count)
    }

    func testAddFavorite() {
        let article = NewsArticle(article_id: "1", title: "Title 1", link: nil, creator: nil, image_url: nil, description: nil, pubDate: nil, content: nil)

        interactor.addFavorite(article: article)

        XCTAssertTrue(mockFavoritesManager.addFavoriteCalled)
        XCTAssertEqual(mockFavoritesManager.addedFavorite?.article_id, article.article_id)
    }

    func testRemoveFavorite() {
        let articleID = "1"
        interactor.removeFavorite(with: articleID)

        XCTAssertTrue(mockFavoritesManager.removeFavoriteCalled)
        XCTAssertEqual(mockFavoritesManager.removedFavoriteID, articleID)
    }

    func testUpdateFavorite() {
        let article = NewsArticle(article_id: "1", title: "Updated Title", link: nil, creator: nil, image_url: nil, description: nil, pubDate: nil, content: nil)

        interactor.updateFavorite(article: article)

        XCTAssertTrue(mockFavoritesManager.updateFavoriteCalled)
        XCTAssertEqual(mockFavoritesManager.updatedFavorite?.article_id, article.article_id)
    }
}

// MARK: - Mock Classes

final class MockFavoritesManager: FavoritesManager {
    var mockFavorites: [NewsArticle] = []

    var addFavoriteCalled = false
    var addedFavorite: NewsArticle?

    var removeFavoriteCalled = false
    var removedFavoriteID: String?

    var updateFavoriteCalled = false
    var updatedFavorite: NewsArticle?

    override func getFavorites() -> [NewsArticle] {
        return mockFavorites
    }

    override func addFavorite(article: NewsArticle) {
        addFavoriteCalled = true
        addedFavorite = article
    }

    override func removeFavorite(with id: String) {
        removeFavoriteCalled = true
        removedFavoriteID = id
    }

    override func updateFavorite(article: NewsArticle) {
        updateFavoriteCalled = true
        updatedFavorite = article
    }
}

final class MockDetailArticleOutput: DetailArticleOutputProtocol {
    var didFetchImageCalled = false
    var fetchedImage: UIImage?
    var isEditable: Bool = false

    init() {}

    func viewDidLoad() {}

    func dismiss() {}

    func didTapLink(with url: String?) {}

    func didToggleFavorite() {}

    func updateFavoriteArctile(title: String?, description: String?) {}

    func didFetchImage(_ image: UIImage?) {
        didFetchImageCalled = true
        fetchedImage = image
    }
}





