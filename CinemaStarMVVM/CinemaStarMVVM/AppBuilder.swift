// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол билдер
protocol BuilderProtocol {
    /// создаем экран Выбора фильмов
    static func makeListFilmModule(listFilmsCoordinator: ListFilmsCoordinator) -> ListFilmsController
    /// создаем экран Деталей фильма
    static func makeDetailsFilmModule(index: IndexPath) -> DetailsFilmViewController

//    static func makeDetailsFilmModule(filmsNetwork: FilmsCommonInfo) -> DetailsFilmViewController
}

/// Билдер
final class AppBuilder: BuilderProtocol {
    static func makeListFilmModule(listFilmsCoordinator: ListFilmsCoordinator) -> ListFilmsController {
        let networkService = NetworkService()
        let viewModel = ListFilmViewModel(listFilmsCoordinator: listFilmsCoordinator, networkService: networkService)
        let view = ListFilmsController(viewModels: viewModel)
        return view
    }

    static func makeDetailsFilmModule(index: IndexPath) -> DetailsFilmViewController {
        let networkService = NetworkService()
        let viewModel = DetailsFilmViewModel(networkService: networkService)
        let view = DetailsFilmViewController(viewModels: viewModel, index: index)
        return view
    }

//    static func makeDetailsFilmModule(filmsNetwork: FilmsCommonInfo) -> DetailsFilmViewController {
//        let networkService = NetworkService()
//        let viewModel = DetailsFilmViewModel(networkService: networkService)
//        let view = DetailsFilmViewController(filmsNetwork: filmsNetwork)
//        return view
//    }
}
