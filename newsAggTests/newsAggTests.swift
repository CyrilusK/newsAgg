//
//  newsAggTests.swift
//  newsAggTests
//
//  Created by Cyril Kardash on 05.12.2024.
//

import XCTest
@testable import newsAgg

final class FavoritesManagerTests: XCTestCase {
    var mockStorage: MockFavoritesStorage!
    var favoritesManager: FavoritesManager!
    
    override func setUp() {
        super.setUp()
        mockStorage = MockFavoritesStorage()
        favoritesManager = FavoritesManager(storage: mockStorage)
    }
    
    func testAddFavorite() {
        let article = NewsArticle(
            article_id: "1",
            title: "title",
            link: "url",
            creator: ["author"],
            image_url: nil,
            description: nil,
            pubDate: "12/12/2024",
            content: "img")
        favoritesManager.addFavorite(article: article)
        
        XCTAssertEqual(favoritesManager.getFavorites().count, 1)
        XCTAssertEqual(favoritesManager.getFavorites().first?.article_id, "1")
    }
    
    func testRemoveFavorite() {
        let article = NewsArticle(
            article_id: "1",
            title: "title",
            link: "url",
            creator: ["author"],
            image_url: nil,
            description: nil,
            pubDate: "12/12/2024",
            content: "img")
        
        favoritesManager.addFavorite(article: article)
        favoritesManager.removeFavorite(with: "1")
        
        XCTAssertTrue(favoritesManager.getFavorites().isEmpty)
    }
    
    func testLoadFavorites() {
        let article = NewsArticle(
            article_id: "1",
            title: "title",
            link: "url",
            creator: ["author"],
            image_url: nil,
            description: nil,
            pubDate: "12/12/2024",
            content: "img")
        mockStorage.mockFavorites = [article]
        favoritesManager = FavoritesManager(storage: mockStorage)
        
        XCTAssertEqual(favoritesManager.getFavorites().count, 1)
        XCTAssertEqual(favoritesManager.getFavorites().first?.title, "title")
    }
}

final class MockFavoritesStorage: FavoritesStorage {
    var mockFavorites: [NewsArticle] = []
    
    func save(favoriteArticle: [newsAgg.NewsArticle]) {
        mockFavorites = favoriteArticle
    }
    
    func load() -> [newsAgg.NewsArticle]? {
        mockFavorites
    }
    
    func remove(favoriteArticleID: String) {
        mockFavorites.removeAll { $0.article_id == favoriteArticleID }
    }
}
