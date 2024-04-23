// ImageLoadingError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Энам с кейсами ошибок при загрузке изображения
enum ImageLoadingError: Error {
    /// Сбой сети
    case networkFailure(Error)
    /// Неверные данные
    case invalidateData
}
