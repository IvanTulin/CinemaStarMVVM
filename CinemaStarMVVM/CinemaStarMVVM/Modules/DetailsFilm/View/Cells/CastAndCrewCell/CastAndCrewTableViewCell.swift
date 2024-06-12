// CastAndCrewTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка актеров и сьемочной группы
final class CastAndCrewTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let collectionCellIdentifier = "collectionCellIdentofier"
        static let nameFontBold = "Verdana-Bold"
        static let nameFont = "Verdana"
        static let nameForTitleLabel = "Актеры и сьемочная группа"
        static let textForLanguageLabel = "Язык"
    }

    // MARK: - Visual Components

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .dirtyGreen
        label.text = "2017/Россия/Сериал"
        label.sizeToFit()
        label.font = UIFont(name: Constants.nameFont, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.nameForTitleLabel
        label.font = UIFont(name: Constants.nameFontBold, size: 14)
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.textForLanguageLabel
        label.textColor = .white
        label.font = UIFont(name: Constants.nameFontBold, size: 14)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameLanguageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dirtyGreen
        label.font = UIFont(name: Constants.nameFontBold, size: 14)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            CastAndCrewCollectionViewCell.self,
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
        setupReleaseDateLabelConstraint()
        setupTitleLabelConstraint()
        setupCollectionViewConstraint()
        setupLanguageLabelConstraint()
        setupNameLanguageLabelConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupReleaseDateLabelConstraint()
        setupTitleLabelConstraint()
        setupCollectionViewConstraint()
        setupLanguageLabelConstraint()
        setupNameLanguageLabelConstraint()
    }

    // MARK: - Public Methods

    func configureCell(detailsFilmsNetwork: DetailsFilmCommonInfo) {
        self.detailsFilmsNetwork = detailsFilmsNetwork
        if (detailsFilmsNetwork.spokenLanguages?.isEmpty) == nil {
            languageLabel.isHidden = true
        } else {
            nameLanguageLabel.text = detailsFilmsNetwork.spokenLanguages?.first?.name
        }
        guard let description = detailsFilmsNetwork.countries.first?.name else { return }
        releaseDateLabel
            .text = "\(detailsFilmsNetwork.year)/ \(description)/ \(detailsFilmsNetwork.type)"
    }

    // MARK: - Private Methods

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 50, height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 22
//        layout.minimumInteritemSpacing = 18
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }

    private func setupReleaseDateLabelConstraint() {
        contentView.addSubview(releaseDateLabel)

        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            releaseDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        ])
    }

    private func setupTitleLabelConstraint() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
    }

    private func setupCollectionViewConstraint() {
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupLanguageLabelConstraint() {
        contentView.addSubview(languageLabel)

        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            languageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
    }

    private func setupNameLanguageLabelConstraint() {
        contentView.addSubview(nameLanguageLabel)

        NSLayoutConstraint.activate([
            nameLanguageLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 3),
            nameLanguageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        ])
    }
}

// MARK: - CastAndCrewTableViewCell + UICollectionViewDataSource

extension CastAndCrewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsFilmsNetwork?.persons?.count ?? 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionCellIdentifier,
            for: indexPath
        ) as? CastAndCrewCollectionViewCell else { return UICollectionViewCell() }
        if let photo = detailsFilmsNetwork?.persons?[indexPath.item].photo {
            cell.configurePersonPhoto(photo: photo)
        }
        if let name = detailsFilmsNetwork?.persons?[indexPath.item].name {
            cell.configurePersonName(name: name)
        }
        return cell
    }
}

// MARK: - CastAndCrewTableViewCell + UICollectionViewDataSource

extension CastAndCrewTableViewCell: UICollectionViewDelegate {}
