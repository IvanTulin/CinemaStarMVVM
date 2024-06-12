// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол NetworkService
protocol NetworkServiceProtocol: AnyObject {
    ///  получаем данные для экрана ListFilms
    /// - Parameters:
    /// completion: клоужер для обработки результатов
    /// - Returns: возращает ListFilms в случае успеха или ошибки в случае неудачи
    func getFilms(completion: @escaping (Result<[FilmsCommonInfo], Error>) -> Void)

    ///  получаем данные для экрана Details
    /// - Parameters:
    /// id: id для параметров path
    /// completion: клоужер для обработки результатов
    /// - Returns: возращает ListFilms в случае успеха или ошибки в случае неудачи
    func getDetailsFilms(id: String, completion: @escaping (Result<DetailsFilmCommonInfo, Error>) -> Void)
}

/// NetworkService
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

// MARK: - NetworkService + NetworkServiceProtocol

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

