// LoadServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерефес взаимодействия LoadService
protocol LoadServiceProtocol {
    /// Загрузка изображения
    /// - Parameters:
    /// - url: URL изображения
    /// - completion: замыкание, возращающее результат запроса и ошибки
    func loadImage(url: URL, completion: @escaping HandlerImage)
}
