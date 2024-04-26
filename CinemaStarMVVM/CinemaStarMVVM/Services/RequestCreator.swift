// RequestCreator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class RequestCreator {
    private enum Constants {
        static let scheme = "https"
        static let host = "api.kinopoisk.dev"
        static let myToken = "3KC34TK-XP1MZB5-MRFJWCB-3T8HV4P"
        static let ninaToken = "HN22RMS-ZDXMNWJ-H7FY4Y5-W90A18G"
    }

    func createFilmRequest() -> URLRequest? {
        var component = URLComponents()
        component.scheme = Constants.scheme
        component.host = Constants.host
        component.path = "/v1.4/movie/search"
        component.queryItems = createQueryItems()

        guard let url = component.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(Constants.ninaToken, forHTTPHeaderField: "X-API-KEY")
        return request
    }

    func createDetailsFilmRequest(id: String) -> URLRequest? {
        var component = URLComponents()
        component.scheme = Constants.scheme
        component.host = Constants.host
        component.path = "/v1.4/movie/\(id)"

        guard let url = component.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(Constants.ninaToken, forHTTPHeaderField: "X-API-KEY")
        return request
    }

    private func createQueryItems() -> [URLQueryItem] {
        let historyFilmQuery = URLQueryItem(name: "query", value: "История")
        return [historyFilmQuery]
    }
}
