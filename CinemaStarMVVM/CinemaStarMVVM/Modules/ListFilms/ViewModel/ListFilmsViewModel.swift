// ListFilmsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ListFilmViewModelProtocol {
    var updateView: ((StateView) -> ())? { get set }
    func fetchFilms()
    func transitionToDetailsFilm(for indexPath: IndexPath)
}

final class ListFilmViewModel: ListFilmViewModelProtocol {
    var updateView: ((StateView) -> ())?
    var networkService: NetworkServiceProtocol?
    var filmsNetwork: [FilmsCommonInfo]?
    // var detailsFilmNetwork: [DetailsFilmCommonInfo]?
    weak var listFilmsCoordinator: ListFilmsCoordinator?

    init(listFilmsCoordinator: ListFilmsCoordinator, networkService: NetworkService) {
        updateView?(.initial)
        self.listFilmsCoordinator = listFilmsCoordinator
        self.networkService = networkService
    }

    func fetchFilms() {
        networkService?.getFilms { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(films):
                self.updateView?(.success(films))
                self.filmsNetwork = films
            case .failure:
                self.updateView?(.failure)
            }
        }
    }

    func transitionToDetailsFilm(for indexPath: IndexPath) {
//        guard let detailsFilm = detailsFilmNetwork?[indexPath.item] else { return }

        if let listFilmCoordinator = listFilmsCoordinator {
            listFilmCoordinator.showDetailsFilm(index: indexPath)
        }
    }

//    func transitionToDetailsFilm(for indexPath: IndexPath) {
//        guard let films = filmsNetwork?[indexPath.item] else { return }
//
//        if let listFilmCoordinator = listFilmsCoordinator {
//            listFilmCoordinator.showDetailsFilm(filmsNetwork: films)
//        }
//    }
}
