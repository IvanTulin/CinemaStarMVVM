// LoadImageService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис загрузки изображения
class LoadImageService: LoadServiceProtocol {
    func loadImage(url: URL, completion: @escaping HandlerImage) {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil

        let session = URLSession(configuration: configuration)
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.invalidateData))
                }
            }
        }.resume()
    }
}
