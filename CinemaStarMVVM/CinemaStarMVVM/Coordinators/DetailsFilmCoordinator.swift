// DetailsFilmCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана выбора фильма
final class DetailsFilmCoordinator: BaseCoordinator {
    // MARK: - Puplic Properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?

    // MARK: - Initializers

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(
            rootViewController: view
        )
    }

    // MARK: - Public Methods

    override func start() {
        showDetailsFilm()
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showDetailsFilm() {
//        let detailsFilmsController = AppBuilder.makeDetailsFilmModule()
//        rootController?.pushViewController(detailsFilmsController, animated: true)
    }
}
