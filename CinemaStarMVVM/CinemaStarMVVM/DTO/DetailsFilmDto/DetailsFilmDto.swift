// DetailsFilmDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
struct DetailsFilmDTO: Codable {
    let name: String
//    let type: String
    let type: TypeFilm
    let year: Int
    let description: String
    let rating: Rating
    let poster: Poster
    let countries: [CountryDTO]
    let persons: [PersonDTO]?
    let spokenLanguages: [SpokenLanguageDTO]?
    let similarMovies: [SimilarMovieDTO]?
}

///
struct CountryDTO: Codable {
    let name: String
}

///
struct PersonDTO: Codable {
    let photo: String?
    let name: String?
}

///
struct SpokenLanguageDTO: Codable {
    let name: String?
    let nameEn: String?
}

///
struct SimilarMovieDTO: Codable {
    let name: String?
    let poster: Poster?
}

///
enum TypeFilm: String, Codable {
    case movie
    case tvSeries = "tv-series"

    var localizedDescription: String {
        switch self {
        case .movie:
            "Фильм"
        case .tvSeries:
            "Сериал"
        }
    }
}
