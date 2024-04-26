// DetailsFilmViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailsFilmViewModelProtocol {
    var updateView: ((DetailsFilmStateView) -> ())? { get set }
    func fetchDetailsFilm()
}

final class DetailsFilmViewModel: DetailsFilmViewModelProtocol {
    // MARK: - Puplic Properties

    var updateView: ((DetailsFilmStateView) -> ())?

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol?
    private var detailsFilmsNetwork: DetailsFilmCommonInfo?
    private var id: Int
    private var detailsFilmResource = DetailsFilmResource()
    private var apiRequest: APIRequest<DetailsFilmResource>?

    // MARK: - Initializers

    init(networkService: NetworkService, id: Int) {
        self.networkService = networkService
        self.id = id
        updateView?(.initial)
    }

    // MARK: - Public Methods

    func fetchDetailsFilm() {
        detailsFilmResource.id = id
        apiRequest = APIRequest(resource: detailsFilmResource)
        apiRequest?.execute { [weak self] result in
            switch result {
            case .none:
                break
            case let .some(film):
                let detailsFilm = DetailsFilmCommonInfo(dto: film)
                self?.updateView?(.success(detailsFilm))
            }
        }

//        networkService?.getDetailsFilms(id: id ?? "") { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(detailsFilms):
//                self.updateView?(.success(detailsFilms))
//            case .failure:
//                self.updateView?(.failure)
//            }
//        }
    }
}
