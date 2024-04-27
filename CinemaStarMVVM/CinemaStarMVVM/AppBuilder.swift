// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол билдер
protocol BuilderProtocol {
    /// создаем экран Выбора фильмов
    static func makeListFilmModule(listFilmsCoordinator: ListFilmsCoordinator) -> ListFilmsController
    /// создаем экран Деталей фильма
    static func makeDetailsFilmModule(id: Int) -> DetailsFilmViewController
}

/// Билдер
final class AppBuilder: BuilderProtocol {
    static func makeListFilmModule(listFilmsCoordinator: ListFilmsCoordinator) -> ListFilmsController {
        let networkService = NetworkService()
        let viewModel = ListFilmViewModel(listFilmsCoordinator: listFilmsCoordinator, networkService: networkService)
        let view = ListFilmsController(viewModels: viewModel)
        return view
    }

    static func makeDetailsFilmModule(id: Int) -> DetailsFilmViewController {
        let networkService = NetworkService()
        let viewModel = DetailsFilmViewModel(networkService: networkService, id: id)
        let view = DetailsFilmViewController(viewModels: viewModel)
        return view
    }
}
