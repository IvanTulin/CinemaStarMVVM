// DetailsFilmViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
class DetailsFilmViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let detailedDescriptionIdentifier = "detailedDescriptionIdentifier"
        static let castAndCrewIdentifier = "castAndCrewIdentifier"
        static let recommendationIdentifier = "recommendationIdentifier"
    }

    /// Тип данных
    enum InforantionType {
        /// подробное описание
        case detailedDescription
        /// актеры и сьемочная группа
        case castAndCrew
        /// рекомендации
        case recommendation
    }

    let informationType: [InforantionType] = [.detailedDescription, .castAndCrew, .recommendation]

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            DetailedDescriptionCell.self,
            forCellReuseIdentifier: Constants.detailedDescriptionIdentifier
        )
        tableView.register(CastAndCrewCell.self, forCellReuseIdentifier: Constants.castAndCrewIdentifier)
        tableView.register(RecommendationCell.self, forCellReuseIdentifier: Constants.recommendationIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTableViewConstraint()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .gray
    }

    private func setupTableViewConstraint() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - DetailsFilmViewController + UICollectionViewDataSource

extension DetailsFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch informationType[indexPath.row] {
        case .detailedDescription:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.detailedDescriptionIdentifier,
                for: indexPath
            ) as? DetailedDescriptionCell else { return UITableViewCell() }
            cell.backgroundColor = .red
            return cell
        case .castAndCrew:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.castAndCrewIdentifier,
                for: indexPath
            ) as? CastAndCrewCell else { return UITableViewCell() }
            cell.backgroundColor = .systemBlue
            return cell
        case .recommendation:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.recommendationIdentifier,
                for: indexPath
            ) as? RecommendationCell else { return UITableViewCell() }
            cell.backgroundColor = .orange
            return cell
        }
    }
}

// MARK: - DetailsFilmViewController + UITableViewDelegate

extension DetailsFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch informationType[indexPath.row] {
        case .detailedDescription:
            return 350
        case .castAndCrew:
            return 80
        case .recommendation:
            // return UITableView.automaticDimension
            return 200
        }
    }
}
