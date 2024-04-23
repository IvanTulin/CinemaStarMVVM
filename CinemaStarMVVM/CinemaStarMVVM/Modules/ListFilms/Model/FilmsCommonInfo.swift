// FilmsCommonInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class FilmsCommonInfo {
    let poster: String
    let name: String
    let rating: Double

    init(dto: DocumentationDTO) {
        poster = dto.poster.url ?? ""
        name = dto.name
        rating = dto.rating.kp
    }
}
