// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор главный
final class AppCoordinator: BaseCoordinator {
    // MARK: - Public Methods

    override func start() {
        toMain()
    }

    // MARK: - Private Methods

    private func toMain() {
        let listFilmsCoordinator = ListFilmsCoordinator()
        let listFilmsModuleView = AppBuilder.makeListFilmModule(listFilmsCoordinator: listFilmsCoordinator)
        listFilmsCoordinator.setRootViewController(view: listFilmsModuleView)
        add(coordinator: listFilmsCoordinator)

        let detailsFilmCoordinator = ListFilmsCoordinator()
        add(coordinator: listFilmsCoordinator)

        detailsFilmCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: listFilmsCoordinator)
            self?.remove(coordinator: detailsFilmCoordinator)
        }

        // setAsRoot​(​_​: listFilmsModuleView)
    }
}
