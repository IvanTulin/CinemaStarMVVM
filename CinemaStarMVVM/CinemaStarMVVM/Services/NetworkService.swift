// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getFilms(completion: @escaping (Result<[FilmsCommonInfo], Error>) -> Void)
}

final class NetworkService {
    private let baseUrlComponents = {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.kinopoisk.dev"
        component.path = "/v1.4/movie/search"
        component.queryItems = [
            .init(name: "query", value: "История")
        ]
        return component
    }()

    private func makeURLRequest<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

extension NetworkService: NetworkServiceProtocol {
    func getFilms(completion: @escaping (Result<[FilmsCommonInfo], Error>) -> Void) {
        guard let url = baseUrlComponents.url else { return }
        var request = URLRequest(url: url)
        request.setValue("3KC34TK-XP1MZB5-MRFJWCB-3T8HV4P", forHTTPHeaderField: "X-API-KEY")

        makeURLRequest(request) { (result: Result<CinemaStarDTO, Error>) in
            switch result {
            case let .success(response):
                let film = response.docs.map { FilmsCommonInfo(dto: $0) }
                completion(.success(film))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
