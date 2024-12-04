//
//  RealmStorage.swift
//  newsAgg
//
//  Created by Cyril Kardash on 05.12.2024.
//

import UIKit
import RealmSwift

protocol FavoritesStorage {
    func save(favoriteArticle: [NewsArticle])
    func load() -> [NewsArticle]?
    func remove(favoriteArticleID: String)
}

final class RealmStorage: FavoritesStorage {
    private let realm: Realm
    
    init() {
        do {
            realm = try Realm()
            print("[DEBUG] - Realm initialized at: \(realm.configuration.fileURL?.absoluteString ?? "No URL")")
        } catch {
            fatalError("[DEBUG] - Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func save(favoriteArticle: [NewsArticle]) {
        do {
            try realm.write {
                let realmArticles = favoriteArticle.map { FavoriteArticle(from: $0) }
                realm.add(realmArticles, update: .modified)
            }
            print("[DEBUG] - Favorite articles saved.")
        } catch {
            print("[DEBUG] - Failed to save favorite articles: \(error.localizedDescription)")
        }
    }
    
    func load() -> [NewsArticle]? {
        let favorities = realm.objects(FavoriteArticle.self)
        print("[DEBUG] - Loaded \(favorities.count) favorite articles.")
        return favorities.map { NewsArticle(from: $0) }
    }
    
    func remove(favoriteArticleID: String) {
        do {
            if let articleToDelete = realm.object(ofType: FavoriteArticle.self, forPrimaryKey: favoriteArticleID) {
                try realm.write {
                    realm.delete(articleToDelete)
                }
                print("[DEBUG] - Favorite article removed.")
            } else {
                print("[DEBUG] - Article not found.")
            }
        } catch {
            print("[DEBUG] - Failed to remove favorite article: \(error.localizedDescription)")
        }
    }
}
