//
//  NewsApiManager.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

enum NewsApiError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)
    case serverError
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return K.invalidURL
        case .noData:
            return K.noData
        case .decodingError(let error):
            return "\(K.decodingError) \(error)"
        case .networkError(let error):
            return "\(K.networkError) \(error)"
        case .serverError:
            return K.serverError
        }
    }
}

final class NewsApiManager {
    func fetchNews(urlString: String) async throws -> NewsResponse {
        guard let url = URL(string: urlString) else {
            print("[DEBUG] Invalid URL")
            throw NewsApiError.invalidURL
        }

        do {
            print("[DEBUG] Starting request to URL: \(url)")
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("[DEBUG] Invalid HTTP response")
                throw NewsApiError.serverError
            }

            print("[DEBUG] HTTP Status Code: \(httpResponse.statusCode)")

            guard !data.isEmpty else {
                print("[DEBUG] No data received from server")
                throw NewsApiError.noData
            }

            do {
                let news = try JSONDecoder().decode(NewsResponse.self, from: data)
                print("[DEBUG] Decoding successful: \(news.results?.count ?? 0)")
                return news
            }
            catch let decodingError {
                print("[DEBUG] Decoding error: \(decodingError)")
                throw NewsApiError.decodingError(decodingError)
            }
        }
        catch let networkError {
            print("[DEBUG] Network error: \(networkError)")
            throw NewsApiError.networkError(networkError)
        }
    }
}

