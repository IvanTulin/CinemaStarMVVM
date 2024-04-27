// ShimmerCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шиммера для коллекции
class ShimmerCollectionViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let nameFilm: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties

    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupImageConstraint()
//        setupNameFilmLabelConstraint()
        setupShimmer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupImageConstraint()
//        setupNameFilmLabelConstraint()
        setupShimmer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        startShimmering()
    }

    // MARK: - Puplic Properties

    func startShimmering() {
        gradientLayer?.removeFromSuperlayer()

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.withAlphaComponent(0.5).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        self.gradientLayer = gradientLayer

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.0
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmerAnimation")

        layer.mask = gradientLayer
    }

    // MARK: - Private Methods

    private func setupShimmer() {
        backgroundColor = UIColor(white: 0.85, alpha: 1.0)
    }

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
            nameFilm.widthAnchor.constraint(equalToConstant: 100),
            nameFilm.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
