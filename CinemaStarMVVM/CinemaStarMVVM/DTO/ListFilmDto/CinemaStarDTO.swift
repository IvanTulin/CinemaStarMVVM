// CinemaStarDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель DTO для ListFilms
struct CinemaStarDTO: Codable {
    let docs: [DocumentationDTO]
}

/// Контейнер для docs
struct DocumentationDTO: Codable {
    let id: Int
    let name: String
    let poster: PosterDTO
    let rating: RatingDTO
}

/// Модель для PosterDTO
struct PosterDTO: Codable {
    let url: String?
}

/// Модель для RatingDTO
struct RatingDTO: Codable {
    let kp: Double
}
