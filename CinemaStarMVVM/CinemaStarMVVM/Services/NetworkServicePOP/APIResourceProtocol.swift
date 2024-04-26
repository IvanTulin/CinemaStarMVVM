// APIResourceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol APIResourceProtocol {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
}

extension APIResourceProtocol {
    var url: URL? {
        guard var components = URLComponents(string: "https://api.kinopoisk.dev") else {
            return nil // Не удалось создать URLComponents
        }

        components.path = methodPath

        if methodPath.contains("search") {
            components.queryItems = [.init(name: "query", value: "История")]
        }

        return components.url // Возвращаем optional URL
    }
}
