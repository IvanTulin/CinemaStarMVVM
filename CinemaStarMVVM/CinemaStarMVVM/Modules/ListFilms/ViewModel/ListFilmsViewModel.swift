// ListFilmsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ListFilmViewModelProtocol {
    var updateView: ((StateView) -> ())? { get set }
    func fetchFilms()
    func transitionToDetailsFilm(id: Int)
}

final class ListFilmViewModel: ListFilmViewModelProtocol {
    var updateView: ((StateView) -> ())?
    var networkService: NetworkServiceProtocol?
    var filmsNetwork: [FilmsCommonInfo]?
    weak var listFilmsCoordinator: ListFilmsCoordinator?
    private var listFilmResource = QuestionsResource()
    private var apiRequest: APIRequest<QuestionsResource>?

    init(listFilmsCoordinator: ListFilmsCoordinator, networkService: NetworkService) {
        self.listFilmsCoordinator = listFilmsCoordinator
        self.networkService = networkService
        updateView?(.initial)
    }

    func fetchFilms() {
        apiRequest = APIRequest(resource: listFilmResource)
        apiRequest?.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .none:
                break
            case let .some(film):
                let listFilm = film.docs.map { FilmsCommonInfo(dto: $0) }
                self.updateView?(.success(listFilm))
            }
        }

//        networkService?.getFilms { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(films):
//                self.updateView?(.success(films))
//                self.filmsNetwork = films
//            case .failure:
//                self.updateView?(.failure)
//            }
//        }
    }

    func transitionToDetailsFilm(id: Int) {
//        if let listFilmCoordinator = listFilmsCoordinator {
//            listFilmCoordinator.showDetailsFilm(id: id)
//        }
        listFilmsCoordinator?.showDetailsFilm(id: id)
    }
}
