// DetailsFilmCommonInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель для DetailsFilmController
final class DetailsFilmCommonInfo {
    /// id фильма
    let id: Int
    /// название фильма
    let name: String
    /// тип фильма
    let type: String
    /// год выпуска фильма
    let year: Int
    /// описание фильма
    let description: String
    /// рейтинг фильма
    let rating: RatingDTO
    /// постер фильма
    let poster: String
    /// место сьемки фильма
    let countries: [CountryDTO]
    /// актерски и сьемочная группа фильма
    let persons: [PersonDTO]?
    /// языки фильма
    let spokenLanguages: [SpokenLanguageDTO]?
    /// рекомендации фильмов
    let similarMovies: [SimilarMovieDTO]?

    init(dto: DetailsFilmDTO) {
        id = dto.id
        name = dto.name
        type = dto.type.localizedDescription
        year = dto.year
        description = dto.description
        rating = dto.rating
        poster = dto.poster.url ?? ""
        countries = dto.countries
        persons = dto.persons
        spokenLanguages = dto.spokenLanguages
        similarMovies = dto.similarMovies
    }
}
