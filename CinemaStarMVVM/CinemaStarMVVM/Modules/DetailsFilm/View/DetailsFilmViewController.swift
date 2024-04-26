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

    private let gradientsLayer = CAGradientLayer()

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
        tableView.register(RecommendationTableViewCell.self, forCellReuseIdentifier: Constants.recommendationIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Private Properties

    private var detailsFilmNetwork: DetailsFilmCommonInfo?
    private var viewModel: DetailsFilmViewModel?

    // MARK: - Initializers

    init(viewModels: DetailsFilmViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel = viewModels
        viewModel?.updateView = { state in
            DispatchQueue.main.async {
                switch state {
                case let .success(detailsFilm):
                    self.detailsFilmNetwork = detailsFilm
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
        setupGradient()
        viewModel?.fetchDetailsFilm()
        configureNavigationItem()
        setupTableViewConstraint()
    }

    // MARK: - Private Methods

    private func configureNavigationItem() {
        let backButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .done,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        backButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
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

    private func setupGradient() {
        view.layer.addSublayer(gradientsLayer)
        gradientsLayer.frame = view.bounds
        gradientsLayer.colors = [UIColor.cream.cgColor, UIColor.darkGreen.cgColor]
    }

    private func createAlertController() {
        let alertController = UIAlertController(
            title: "Упс",
            message: "Функционал в разработке :(",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Ок", style: .cancel)
        alertController.addAction(action)

        present(alertController, animated: true)
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
            cell.backgroundColor = .clear
            if let detailsFilm = detailsFilmNetwork {
                cell.confifureCell(detailsFilmsNetwork: detailsFilm)
            }
            cell.completionHandler = {
                self.createAlertController()
            }
            return cell
        case .detailedDescription:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.detailedDescriptionIdentifier,
                for: indexPath
            ) as? DetailedDescriptionCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            if let detailsFilm = detailsFilmNetwork {
                cell.confifureCell(detailsFilmsNetwork: detailsFilm)
            }
            return cell
        case .castAndCrew:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.castAndCrewIdentifier,
                for: indexPath
            ) as? CastAndCrewTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            if let detailsFilm = detailsFilmNetwork {
                cell.configureCell(detailsFilmsNetwork: detailsFilm)
                cell.collectionView.reloadData()
            }

            return cell
        case .recommendation:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.recommendationIdentifier,
                for: indexPath
            ) as? RecommendationTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            if let detailsFilm = detailsFilmNetwork {
                if (detailsFilm.similarMovies?.isEmpty) == nil {
                    cell.isHidden = true
                } else {
                    cell.configureCell(detailsFilmsNetwork: detailsFilm)
                    cell.collectionView.reloadData()
                }
            }
            return cell
        }
    }
}

// MARK: - DetailsFilmViewController + UITableViewDelegate

extension DetailsFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch informationType[indexPath.row] {
        case .posterAndRating:
            return 285
        case .detailedDescription:
            return 145
        case .castAndCrew:
            return 190
        case .recommendation:
            // return UITableView.automaticDimension
            return 290
        }
    }
}

// extension DetailsFilmViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y > 0 {
//            navigationController?.navigationBar.backgroundColor = .clear
//        } else {
//            navigationController?.navigationBar.backgroundColor = view.backgroundColor
//        }
//    }
// }
