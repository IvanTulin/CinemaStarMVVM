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
}

///
struct Poster: Codable {
    let url: String?
}

///
struct Rating: Codable {
    let kp: Double
}
