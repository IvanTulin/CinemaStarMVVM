// QuestionsResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
struct QuestionsResource: APIResourceProtocol {
    typealias ModelType = CinemaStarDTO
    var id: Int?

    var methodPath: String {
        guard let id else {
            return "/v1.4/movie/search"
        }
        return "/v1.4/movie/\(id)"
    }
}
