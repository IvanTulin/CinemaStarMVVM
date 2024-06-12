// PosterAndRatingCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с постером и рейтингом фильма
class PosterAndRatingCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let nameFont = "Verdana"
        static let nameFontBold = "Verdana-Bold"
    }

    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let poster = UIImageView()
        poster.backgroundColor = .systemBlue
        poster.layer.cornerRadius = 8
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()

    private let nameFilmLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Name\nFilms"
        label.font = UIFont(name: Constants.nameFontBold, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "⭐️ 0.0"
        label.font = UIFont(name: Constants.nameFont, size: 16)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startViewingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGreen
        button.setTitle("Смотреть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPosterImageViewConstarint()
        setupNameFilmLabelConstraint()
        setupRatingLabelConstraint()
        setupStartViewingButtonConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPosterImageViewConstarint()
        setupNameFilmLabelConstraint()
        setupRatingLabelConstraint()
        setupStartViewingButtonConstraint()
    }

    // MARK: - Public Methods

    func confifureCell(detailsFilmsNetwork: DetailsFilmCommonInfo) {
        posterImageView.downloaded(from: detailsFilmsNetwork.poster)
        nameFilmLabel.text = detailsFilmsNetwork.name
        ratingLabel.text = "⭐️ \(detailsFilmsNetwork.rating)"
    }

//    func confifureCell(filmsNetwork: FilmsCommonInfo) {
//        posterImageView.downloaded(from: filmsNetwork.poster)
//        nameFilmLabel.text = filmsNetwork.name
//        ratingLabel.text = "⭐️ \(filmsNetwork.rating)"
//    }

    // MARK: - Private Methods

    private func setupPosterImageViewConstarint() {
        contentView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            posterImageView.widthAnchor.constraint(equalToConstant: 170),
            posterImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupNameFilmLabelConstraint() {
        contentView.addSubview(nameFilmLabel)

        NSLayoutConstraint.activate([
            nameFilmLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            nameFilmLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 16),
            nameFilmLabel.widthAnchor.constraint(equalToConstant: 120),
            nameFilmLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func setupRatingLabelConstraint() {
        contentView.addSubview(ratingLabel)

        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: nameFilmLabel.bottomAnchor, constant: 1),
            ratingLabel.leftAnchor.constraint(equalTo: nameFilmLabel.leftAnchor)
        ])
    }

    private func setupStartViewingButtonConstraint() {
        contentView.addSubview(startViewingButton)

        NSLayoutConstraint.activate([
            startViewingButton.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            startViewingButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            startViewingButton.widthAnchor.constraint(equalToConstant: 358),
            startViewingButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
