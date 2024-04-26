// DetailsFilmCommonInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class DetailsFilmCommonInfo {
    let name: String
    let type: String
    let year: Int
    let description: String
    let rating: Rating
    let poster: String
    let countries: [CountryDTO]
    let persons: [PersonDTO]?
    let spokenLanguages: [SpokenLanguageDTO]?
    let similarMovies: [SimilarMovieDTO]?

    init(dto: DetailsFilmDTO) {
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
