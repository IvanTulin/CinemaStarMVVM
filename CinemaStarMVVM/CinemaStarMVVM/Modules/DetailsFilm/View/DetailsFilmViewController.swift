// DetailsFilmViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран деталей фильма
class DetailsFilmViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let posterAndRatingIdentifier = "posterAndRatingIdentifier"
        static let detailedDescriptionIdentifier = "detailedDescriptionIdentifier"
        static let castAndCrewIdentifier = "castAndCrewIdentifier"
        static let recommendationIdentifier = "recommendationIdentifier"
    }

    /// Тип данных
    enum InforantionType {
        /// постер и рейтинг фильма
        case posterAndRating
        /// подробное описание
        case detailedDescription
        /// актеры и сьемочная группа
        case castAndCrew
        /// рекомендации
        case recommendation
    }

    let informationType: [InforantionType] = [.posterAndRating, .detailedDescription, .castAndCrew, .recommendation]

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            PosterAndRatingCell.self,
            forCellReuseIdentifier: Constants.posterAndRatingIdentifier
        )
        tableView.register(
            DetailedDescriptionCell.self,
            forCellReuseIdentifier: Constants.detailedDescriptionIdentifier
        )
        tableView.register(CastAndCrewTableViewCell.self, forCellReuseIdentifier: Constants.castAndCrewIdentifier)
        tableView.register(RecommendationCell.self, forCellReuseIdentifier: Constants.recommendationIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Private Properties

//    private var filmsNetwork: FilmsCommonInfo?
    private var detailsFilmNetwork: DetailsFilmCommonInfo?
    private var viewModel: DetailsFilmViewModel?

    // MARK: - Initializers

    init(viewModels: DetailsFilmViewModel, index: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        viewModel = viewModels
        viewModel?.updateView = { state in
            DispatchQueue.main.async {
                switch state {
                case let .success(detailsFilm):
                    self.detailsFilmNetwork = detailsFilm[index.row]
                    self.tableView.reloadData()
                case .initial, .failure, .loading:
                    break
                }
            }
        }
    }

//    init(filmsNetwork: FilmsCommonInfo) {
//        super.init(nibName: nil, bundle: nil)
//        self.filmsNetwork = filmsNetwork
//    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchDetailsFilm()
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
        informationType.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch informationType[indexPath.row] {
        case .posterAndRating:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.posterAndRatingIdentifier,
                for: indexPath
            ) as? PosterAndRatingCell else { return UITableViewCell() }
            cell.backgroundColor = .red
//            if let detailsFilm = filmsNetwork {
//                cell.confifureCell(filmsNetwork: detailsFilm)
//            }
            if let detailsFilm = detailsFilmNetwork {
                cell.confifureCell(detailsFilmsNetwork: detailsFilm)
            }
            return cell
        case .detailedDescription:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.detailedDescriptionIdentifier,
                for: indexPath
            ) as? DetailedDescriptionCell else { return UITableViewCell() }
            cell.backgroundColor = .gray
            if let detailsFilm = detailsFilmNetwork {
                cell.confifureCell(detailsFilmsNetwork: detailsFilm)
            }
            return cell
        case .castAndCrew:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.castAndCrewIdentifier,
                for: indexPath
            ) as? CastAndCrewTableViewCell else { return UITableViewCell() }
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
        case .posterAndRating:
            return 300
        case .detailedDescription:
            return 145
        case .castAndCrew:
            return 170
        case .recommendation:
            // return UITableView.automaticDimension
            return 270
        }
    }
}
