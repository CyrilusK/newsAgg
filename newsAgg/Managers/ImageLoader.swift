//
//  ImageLoader.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

final class ImageLoader {
    func loadImage(from url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
