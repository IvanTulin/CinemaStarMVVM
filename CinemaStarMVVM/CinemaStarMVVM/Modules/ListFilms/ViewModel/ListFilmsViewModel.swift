// ListFilmsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для ListFilmViewModel
protocol ListFilmViewModelProtocol {
    /// Rложура для передачи значений на View
    var updateView: ((StateView) -> ())? { get set }
    /// Получить данные фильма
    func fetchFilms()
    /// Переход на экран Деталей фильма
    /// - Parameter id: id фильма
    func transitionToDetailsFilm(id: Int)
    /// Cмена стейта
    var state: StateView { get set }
}

final class ListFilmViewModel: ListFilmViewModelProtocol {
    // MARK: - Puplic Properties

    var updateView: ((StateView) -> ())?
    var networkService: NetworkServiceProtocol?
    var filmsNetwork: [FilmsCommonInfo]?
    weak var listFilmsCoordinator: ListFilmsCoordinator?

    var state: StateView = .initial {
        didSet {
            updateView?(state)
        }
    }

    // MARK: - Private Properties

    private var listFilmResource = QuestionsResource()
    private var apiRequest: APIRequest<QuestionsResource>?

    // MARK: - Initializers

    init(listFilmsCoordinator: ListFilmsCoordinator, networkService: NetworkServiceProtocol) {
        self.listFilmsCoordinator = listFilmsCoordinator
        self.networkService = networkService
        updateView?(.initial)
    }

    // MARK: - Public Methods

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
    }

    func transitionToDetailsFilm(id: Int) {
        listFilmsCoordinator?.showDetailsFilm(id: id)
    }
}
