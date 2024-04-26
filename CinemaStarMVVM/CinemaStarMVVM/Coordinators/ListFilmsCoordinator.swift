// ListFilmsCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана выбора фильма
final class ListFilmsCoordinator: BaseCoordinator {
    // MARK: - Puplic Properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?

    // MARK: - Initializers

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(
            rootViewController: view
        )
        setAsRoot​(​_​: rootController ?? UINavigationController(
            rootViewController: UIViewController()
        ))
    }

    // MARK: - Public Methods

    override func start() {
        showListFilms()
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showListFilms() {
        let listFilmsController = AppBuilder.makeListFilmModule(listFilmsCoordinator: self)
        rootController?.pushViewController(listFilmsController, animated: true)
    }

    func showDetailsFilm(id: Int) {
        let detailsFilmsController = AppBuilder.makeDetailsFilmModule(id: id)
        rootController?.pushViewController(detailsFilmsController, animated: true)
    }

//    func showDetailsFilm(filmsNetwork: FilmsCommonInfo) {
//        let detailsFilmsController = AppBuilder.makeDetailsFilmModule(filmsNetwork: filmsNetwork)
//        rootController?.pushViewController(detailsFilmsController, animated: true)
//    }
}
