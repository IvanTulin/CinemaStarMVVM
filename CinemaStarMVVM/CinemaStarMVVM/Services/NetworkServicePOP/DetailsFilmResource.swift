// DetailsFilmResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
struct DetailsFilmResource: APIResourceProtocol {
    typealias ModelType = DetailsFilmDTO
    var id: Int?

    var methodPath: String {
        guard let id else {
            return "/v1.4/movie/id"
        }
        return "/v1.4/movie/\(id)"
    }
}
