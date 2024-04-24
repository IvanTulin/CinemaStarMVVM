// DetailsFilmViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailsFilmViewModelProtocol {
    var updateView: ((DetailsFilmStateView) -> ())? { get set }
    func fetchDetailsFilm()
}

final class DetailsFilmViewModel: DetailsFilmViewModelProtocol {
    var updateView: ((DetailsFilmStateView) -> ())?
    var networkService: NetworkServiceProtocol?
    var detailsFilmsNetwork: [DetailsFilmCommonInfo]?

    init(networkService: NetworkService) {
        updateView?(.initial)
        self.networkService = networkService
    }

    func fetchDetailsFilm() {
        networkService?.getDetailsFilms { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(detailsFilms):
                self.updateView?(.success(detailsFilms))
            // self.detailsFilmsNetwork = detailsFilms
            case .failure:
                self.updateView?(.failure)
            }
        }
    }
}
