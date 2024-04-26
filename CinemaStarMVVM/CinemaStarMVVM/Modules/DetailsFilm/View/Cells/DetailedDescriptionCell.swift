// DetailedDescriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка детального описания фильма
class DetailedDescriptionCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let nameFont = "Verdana"
        static let textForDescriptionFilm = "Текст описания"
    }

    // MARK: - Visual Components

    private let descriptionFilmLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = Constants.textForDescriptionFilm
        label.font = UIFont(name: Constants.nameFont, size: 14)
        label.layer.borderWidth = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDescriptionFilmLabelConstraint()
        setupReleaseDateLabelConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDescriptionFilmLabelConstraint()
        setupReleaseDateLabelConstraint()
    }

    // MARK: - Public Methods

    func confifureCell(detailsFilmsNetwork: DetailsFilmCommonInfo) {
        descriptionFilmLabel.text = detailsFilmsNetwork.description
        guard let description = detailsFilmsNetwork.countries.first?.name else { return }
        releaseDateLabel
            .text = "\(detailsFilmsNetwork.year)/ \(description)/ \(detailsFilmsNetwork.type)"
    }

    // MARK: - Private Methods

    private func setupDescriptionFilmLabelConstraint() {
        contentView.addSubview(descriptionFilmLabel)

        NSLayoutConstraint.activate([
            descriptionFilmLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            descriptionFilmLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            descriptionFilmLabel.widthAnchor.constraint(equalToConstant: 330),
            descriptionFilmLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupReleaseDateLabelConstraint() {
        contentView.addSubview(releaseDateLabel)

        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: descriptionFilmLabel.bottomAnchor, constant: 10),
            releaseDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        ])
    }
}
