// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getFilms(completion: @escaping (Result<[FilmsCommonInfo], Error>) -> Void)
    func getDetailsFilms(id: String, completion: @escaping (Result<DetailsFilmCommonInfo, Error>) -> Void)
}

final class NetworkService {
    var requestCreator = RequestCreator()

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
        guard let request = requestCreator.createFilmRequest() else { return }

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

    func getDetailsFilms(id: String, completion: @escaping (Result<DetailsFilmCommonInfo, Error>) -> Void) {
        guard let request = requestCreator.createDetailsFilmRequest(id: id) else { return }

        makeURLRequest(request) { (result: Result<DetailsFilmDTO, Error>) in
            switch result {
            case let .success(response):
//                let film = response.map { DetailsFilmCommonInfo(dto: $0) }
                let film = DetailsFilmCommonInfo(dto: response)
                completion(.success(film))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

//// Определение протоколов для каждой задачи
// protocol URLComponentsProviding {
//    var baseUrlComponents: URLComponents { get }
// }
//
// protocol URLRequestMaking {
//    func makeURLRequest<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
// }
//
// protocol FilmsFetching {
//    func getFilms(completion: @escaping (Result<[FilmsCommonInfo], Error>) -> Void)
// }
//
//// Реализация протоколов
// final class URLComponentsProvider: URLComponentsProviding {
//    var baseUrlComponents: URLComponents {
//        var component = URLComponents()
//        component.scheme = "https"
//        component.host = "api.kinopoisk.dev"
//        component.path = "/v1.4/movie/search"
//        component.queryItems = [
//            .init(name: "query", value: "История")
//        ]
//        return component
//    }
// }
//
// final class URLRequestMaker: URLRequestMaking {
//    func makeURLRequest<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else { return }
//            do {
//                let result = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(result))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
// }
//
// final class FilmsFetcher: FilmsFetching {
//    private let componentsProvider: URLComponentsProviding
//    private let requestMaker: URLRequestMaking
//
//    init(componentsProvider: URLComponentsProviding, requestMaker: URLRequestMaking) {
//        self.componentsProvider = componentsProvider
//        self.requestMaker = requestMaker
//    }
//
//    func getFilms(completion: @escaping (Result<[FilmsCommonInfo], Error>) -> Void) {
//        guard let url = componentsProvider.baseUrlComponents.url else { return }
//        var request = URLRequest(url: url)
//        request.setValue("3KC34TK-XP1MZB5-MRFJWCB-3T8HV4P", forHTTPHeaderField: "
