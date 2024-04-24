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

// final class FilmsCommonInfo {
//    let poster: String
//    let name: String
//    let rating: Double
//    let description: String
//    let year: Int
//    var countries: [Country]
//    let type: TypeArtwork
//
//    init(dto: DocumentationDTO) {
//        poster = dto.poster.url ?? ""
//        name = dto.name
//        rating = dto.rating.kp
//        description = dto.description
//        year = dto.year
//        countries = dto.countries
//        type = dto.type
//    }
// }
