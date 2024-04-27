// RecommendationCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///Ячейка коллекции фильмов-рекомендаций
class RecommendationCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let nameFont = "Verdana"
    }

    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleToFill
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 8
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()

    private let filmNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.nameFont, size: 16)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPosterImageViewConstraint()
        setupfilmNameLabelConstraint()
        contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPosterImageViewConstraint()
        setupfilmNameLabelConstraint()
        contentView.backgroundColor = .clear
    }

    // MARK: - Public Methods

    func configureRecomendationFilm(recomendationFilm: SimilarMovieDTO) {
        posterImageView.downloaded(from: recomendationFilm.poster?.url ?? "")
        filmNameLabel.text = recomendationFilm.name
    }

    // MARK: - Private Methods

    private func setupPosterImageViewConstraint() {
        contentView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 170),
            posterImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupfilmNameLabelConstraint() {
        contentView.addSubview(filmNameLabel)

        NSLayoutConstraint.activate([
            filmNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            filmNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
    }
}
