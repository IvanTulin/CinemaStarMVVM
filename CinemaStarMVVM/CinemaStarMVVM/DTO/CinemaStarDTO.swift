// CinemaStarDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
struct CinemaStarDTO: Codable {
    let docs: [DocumentationDTO]
}

///
struct DocumentationDTO: Codable {
    let name: String
    let poster: Poster
    let rating: Rating
    let description: String
    let year: Int
    let countries: [Country]
    let type: TypeArtwork
}

///
struct Poster: Codable {
    let url: String?
}

///
struct Rating: Codable {
    let kp: Double
}

///
struct Country: Codable {
    let name: String
}

///
enum TypeArtwork: String, Codable {
    case movie
    case tvSeries = "tv-series"

    var localizedDescriptions: String {
        switch self {
        case .movie:
            return "Фильм"
        case .tvSeries:
            return "Сериал"
        }
    }
}
