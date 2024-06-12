// CastAndCrewTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка актеров и сьемочной группы
class CastAndCrewTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let nameFontBold = "Verdana-Bold"
        static let nameForTitleLabel = "Актеры и сьемочная группа"
    }

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.nameForTitleLabel
        label.font = UIFont(name: Constants.nameFontBold, size: 14)
        label.textColor = .white
        label.sizeToFit()
        label.layer.borderWidth = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        return collectionView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitleLabelConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTitleLabelConstraint()
    }

    // MARK: - Private Methods

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 46, height: 73)
        layout.minimumLineSpacing = 17
//        layout.minimumInteritemSpacing = 18
//        layout.sectionInset = .init(top: 14, left: 16, bottom: 0, right: 16)
        return layout
    }

    private func setupTitleLabelConstraint() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
    }
}
