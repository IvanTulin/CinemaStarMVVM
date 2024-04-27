// FilmsCommonInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель для ListFilmsController
final class FilmsCommonInfo {
    /// айди
    let id: Int
    /// постер фильма
    let poster: String
    /// название фильма
    let name: String
    /// рейтинг фильма
    let rating: Double

    init(dto: DocumentationDTO) {
        id = dto.id
        poster = dto.poster.url ?? ""
        name = dto.name
        rating = dto.rating.kp
    }
}
