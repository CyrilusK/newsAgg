//
//  FileManager.swift
//  newsAgg
//
//  Created by Cyril Kardash on 29.10.2024.
//

import UIKit

final class FileManager {
    private func documentsDirUrl() -> URL? {
        let url = try? Foundation.FileManager.default.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: false)
        print("[DEBUG] - Documents Directory URL: \(url?.absoluteString ?? "nil")")
        return url
    }
    
    func saveFavoriteToFile(favoriteArticle: [NewsArticle]) {
        guard let url = documentsDirUrl()?.appendingPathComponent(K.favoriteArcitlesJson) else {
            print("[DEBUG] - failed to get documents dir url")
            return
        }
        print("[DEBUG] - \(url)")
        do {
            let data = try JSONEncoder().encode(favoriteArticle)
            try data.write(to: url)
            print("[DEBUG] - Favorite articles saved to \(url)")
        } catch {
            print("[DEBUG] - Failed to save favorite articles: \(error.localizedDescription)")
        }
    }
    
    func loadFavoriteFromFile() -> [NewsArticle]? {
        guard let url = documentsDirUrl()?.appendingPathComponent(K.favoriteArcitlesJson) else {
            print("[DEBUG] - failed to get documents dir url")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let favorites = try JSONDecoder().decode([NewsArticle].self, from: data)
            print("[DEBUG] - Favorite articles loaded from \(url)")
            return favorites
        } catch {
            print("[DEBUG] - Failed to load favorite articles: \(error.localizedDescription)")
            return nil
        }
    }
}
