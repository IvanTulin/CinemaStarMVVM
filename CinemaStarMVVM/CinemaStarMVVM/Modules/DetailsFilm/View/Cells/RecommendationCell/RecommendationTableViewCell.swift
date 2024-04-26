// RecommendationTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фильмов-рекомендаций
class RecommendationTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let collectionCellIdentifier = "collectionCellIdentofier"
        static let nameFontBold = "Verdana-Bold"
        static let textForRecomendationLabel = "Смотрите также"
    }

    // MARK: - Visual Components

    private let recomendationLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.textForRecomendationLabel
        label.font = UIFont(name: Constants.nameFontBold, size: 14)
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        // collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            RecommendationCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.collectionCellIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Puplic Properties

    var detailsFilmsNetwork: DetailsFilmCommonInfo?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupRecomendationLabelConstraint()
        setupCollectionViewConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupRecomendationLabelConstraint()
        setupCollectionViewConstraint()
    }

    // MARK: - Public Methods

    func configureCell(detailsFilmsNetwork: DetailsFilmCommonInfo) {
        self.detailsFilmsNetwork = detailsFilmsNetwork
    }

    // MARK: - Private Methods

    private func setupRecomendationLabelConstraint() {
        contentView.addSubview(recomendationLabel)

        NSLayoutConstraint.activate([
            recomendationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            recomendationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
    }

    private func setupCollectionViewConstraint() {
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: recomendationLabel.bottomAnchor, constant: 8),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 251)
        ])
    }

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 180, height: 210)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 22
//        layout.minimumInteritemSpacing = 18
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}

extension RecommendationTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsFilmsNetwork?.similarMovies?.count ?? 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionCellIdentifier,
            for: indexPath
        ) as? RecommendationCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        if let recomendationFilm = detailsFilmsNetwork?.similarMovies?[indexPath.item] {
            cell.configureRecomendationFilm(recomendationFilm: recomendationFilm)
        }
        return cell
    }
}
