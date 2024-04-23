// FilmCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фильма
class FilmCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        image.layer.borderWidth = 2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let nameFilm: UILabel = {
        let label = UILabel()
        // label.textColor = .white
        // label.text = "name text"
        label.sizeToFit()
        label.layer.borderWidth = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingFilm: UILabel = {
        let label = UILabel()
        // label.textColor = .white
        // label.text = "⭐️ rating text"
        label.sizeToFit()
        label.layer.borderWidth = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageConstraint()
        setupNameFilmLabelConstraint()
        setupRatingFilmLabelConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageConstraint()
        setupNameFilmLabelConstraint()
        setupRatingFilmLabelConstraint()
    }

    // MARK: - Public Methods

    func setupCell(filmsNetwork: FilmsCommonInfo) {
        posterImageView.downloaded(from: filmsNetwork.poster)
        nameFilm.text = filmsNetwork.name
        ratingFilm.text = "\(filmsNetwork.rating)"
    }

    // MARK: - Private Methods

    private func setupImageConstraint() {
        clipsToBounds = true
        contentView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 170),
            posterImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupNameFilmLabelConstraint() {
        contentView.addSubview(nameFilm)

        NSLayoutConstraint.activate([
            nameFilm.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            nameFilm.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            nameFilm.widthAnchor.constraint(equalToConstant: 100),
//            nameFilm.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupRatingFilmLabelConstraint() {
        contentView.addSubview(ratingFilm)

        NSLayoutConstraint.activate([
            ratingFilm.topAnchor.constraint(equalTo: nameFilm.bottomAnchor, constant: 4),
            ratingFilm.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            ratingFilm.widthAnchor.constraint(equalToConstant: 100),
//            ratingFilm.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
