// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор базовый
class BaseCoordinator {
    // MARK: - Private Properties

    private var childCoordinator: [BaseCoordinator] = []

    // MARK: - Public Methods

    func start() {
        fatalError("child должен быть реализован")
    }

    func add(coordinator: BaseCoordinator) {
        childCoordinator.append(coordinator)
    }

    func remove(coordinator: BaseCoordinator) {
        childCoordinator = childCoordinator.filter { $0 !== coordinator }
    }

    func setAsRoot​(​_​ controller: UIViewController) {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .last { $0.isKeyWindow }
        window?.rootViewController = controller
    }
}
