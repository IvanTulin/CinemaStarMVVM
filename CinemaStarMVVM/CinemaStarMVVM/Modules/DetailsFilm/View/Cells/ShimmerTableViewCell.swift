// ShimmerTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шиммера таблицы
final class ShimmerTableViewCell: UITableViewCell {
    private var gradientLayer: CAGradientLayer?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupShimmer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShimmer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        startShimmering()
    }

    // MARK: - Public Methods

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
}
