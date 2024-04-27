// DetailsFilmViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// swiftlint:disable all
/// Экран деталей фильма
class DetailsFilmViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let posterAndRatingIdentifier = "posterAndRatingIdentifier"
        static let detailedDescriptionIdentifier = "detailedDescriptionIdentifier"
        static let castAndCrewIdentifier = "castAndCrewIdentifier"
        static let recommendationIdentifier = "recommendationIdentifier"
        static let shimmerCellIdentifier = "shimmerCellIdentifier"
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
        tableView.register(ShimmerTableViewCell.self, forCellReuseIdentifier: Constants.shimmerCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Puplic Properties

    var detailedDescriptionLabelHeight: CGFloat = 100 // Начальное значение

    // MARK: - Private Properties

    // private var detailsFilmNetwork: DetailsFilmCommonInfo?
    private var viewModel: DetailsFilmViewModelProtocol?
    private let gradientsLayerFoShiimer = CAGradientLayer()
    private var isLoading = true
    private var isFavorite = false
    private let favoriteButton = UIBarButtonItem()

    // MARK: - Initializers

    init(viewModels: DetailsFilmViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel = viewModels
        viewModel?.updateView = { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch state {
                case let .success(detailsFilm):
                    self.isLoading = false
                    // self.detailsFilmNetwork = detailsFilm
                    self.viewModel?.detailsFilmsNetwork = detailsFilm
                    if let favoriteMovieId = self.viewModel?.favoritesService.loadFavoriteMovie(),
                       favoriteMovieId ==
                       self.viewModel?.detailsFilmsNetwork?.id
                    {
                        self.isFavorite = true
                    } else {
                        self.isFavorite = false
                    }
                    self.updateFavoriteButtonState()

                    self.tableView.reloadData()
                case .initial, .failure, .loading:
                    break
                }
            }
        }
    }

//    init(viewModels: DetailsFilmViewModel) {
//        super.init(nibName: nil, bundle: nil)
//        viewModel = viewModels
//        viewModel?.updateView = { [weak self] state in
//            guard let self = self else { return }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                switch state {
//                case let .success(detailsFilm):
//                    self.isLoading = false
//                    self.detailsFilmNetwork = detailsFilm
//                    self.tableView.reloadData()
//                case .initial, .failure, .loading:
//                    break
//                }
//            }
//        }
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
        favoriteButton.style = .plain
        favoriteButton.target = self
        favoriteButton.action = #selector(addFavorites)
        navigationItem.rightBarButtonItem = favoriteButton

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

    private func updateFavoriteButtonState() {
        if isFavorite {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButton.image = UIImage(systemName: "heart")
        }
    }

    @objc private func addFavorites() {
        isFavorite = !isFavorite
        updateFavoriteButtonState()

        if isFavorite {
            viewModel?.favoritesService.saveFavoriteMovie(movieId: viewModel?.detailsFilmsNetwork?.id ?? 0)
        } else {
            UserDefaults.standard.set(nil, forKey: "favoriteMovieId")
        }
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
            if isLoading {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.shimmerCellIdentifier,
                    for: indexPath
                ) as? ShimmerTableViewCell else { return UITableViewCell() }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.posterAndRatingIdentifier,
                    for: indexPath
                ) as? PosterAndRatingCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                if let detailsFilm = viewModel?.detailsFilmsNetwork {
                    cell.confifureCell(detailsFilmsNetwork: detailsFilm)
                }
                cell.completionHandler = {
                    self.createAlertController()
                }
                return cell
            }
        case .detailedDescription:
            if isLoading {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.shimmerCellIdentifier,
                    for: indexPath
                ) as? ShimmerTableViewCell else { return UITableViewCell() }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.detailedDescriptionIdentifier,
                    for: indexPath
                ) as? DetailedDescriptionCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                if let detailsFilm = viewModel?.detailsFilmsNetwork {
                    cell.confifureCell(detailsFilmsNetwork: detailsFilm)
                }
                return cell
            }
        case .castAndCrew:
            if isLoading {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.shimmerCellIdentifier,
                    for: indexPath
                ) as? ShimmerTableViewCell else { return UITableViewCell() }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.castAndCrewIdentifier,
                    for: indexPath
                ) as? CastAndCrewTableViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                if let detailsFilm = viewModel?.detailsFilmsNetwork {
                    cell.configureCell(detailsFilmsNetwork: detailsFilm)
                    cell.collectionView.reloadData()
                }
                return cell
            }
        case .recommendation:
            if isLoading {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.shimmerCellIdentifier,
                    for: indexPath
                ) as? ShimmerTableViewCell else { return UITableViewCell() }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.recommendationIdentifier,
                    for: indexPath
                ) as? RecommendationTableViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                if let detailsFilm = viewModel?.detailsFilmsNetwork {
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
}

// MARK: - DetailsFilmViewController + UITableViewDelegate

extension DetailsFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch informationType[indexPath.row] {
        case .posterAndRating:
            return 285
        case .detailedDescription:
            return detailedDescriptionLabelHeight
        case .castAndCrew:
            return 215
        case .recommendation:
            return 290
        }
    }
}

// swiftlint:enable all
