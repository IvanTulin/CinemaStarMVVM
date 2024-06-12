// DetailsFilmDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель DTO для DetailsFilm
struct DetailsFilmDTO: Codable {
    let id: Int
    let name: String
    let type: TypeFilm
    let year: Int
    let description: String
    let rating: RatingDTO
    let poster: PosterDTO
    let countries: [CountryDTO]
    let persons: [PersonDTO]?
    let spokenLanguages: [SpokenLanguageDTO]?
    let similarMovies: [SimilarMovieDTO]?
}

/// Контейнер для countries
struct CountryDTO: Codable {
    let name: String
}

/// Контейнер для persons
struct PersonDTO: Codable {
    let photo: String?
    let name: String?
}

/// Контейнер для spokenLanguages
struct SpokenLanguageDTO: Codable {
    let name: String?
    let nameEn: String?
}

/// Контейнер для similarMovies
struct SimilarMovieDTO: Codable {
    let name: String?
    let poster: PosterDTO?
}

/// Энам для типа фильмов
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
