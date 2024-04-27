// DetailedDescriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// swiftlint:disable all

/// Ячейка детального описания фильма
class DetailedDescriptionCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let nameTitltButton = "chevron.down"
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var chevronDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.nameTitltButton), for: .normal)
        button.tintColor = .white
        button.sizeToFit()
        button.addTarget(self, action: #selector(toggleDescriptionHeight), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Puplic Properties

    var currentLabelHeight: CGFloat {
        descriptionFilmLabelHeightConstraint?.constant ?? 145
    }

    // MARK: - Private Properties

    private var descriptionFilmLabelHeightConstraint: NSLayoutConstraint!
    private var isLabelExpanded = false

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDescriptionFilmLabelConstraint()
        setupChevronDownButtonConstarints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDescriptionFilmLabelConstraint()
        setupChevronDownButtonConstarints()
    }

    // MARK: - Public Methods

    func confifureCell(detailsFilmsNetwork: DetailsFilmCommonInfo) {
        descriptionFilmLabel.text = detailsFilmsNetwork.description
    }

    // MARK: - Private Methods

    private func setupDescriptionFilmLabelConstraint() {
        contentView.addSubview(descriptionFilmLabel)

        descriptionFilmLabelHeightConstraint = descriptionFilmLabel.heightAnchor.constraint(equalToConstant: 100)
        // descriptionFilmLabelHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            descriptionFilmLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            descriptionFilmLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            descriptionFilmLabel.widthAnchor.constraint(equalToConstant: 330),
            descriptionFilmLabelHeightConstraint
            // descriptionFilmLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupChevronDownButtonConstarints() {
        contentView.addSubview(chevronDownButton)

        NSLayoutConstraint.activate([
            chevronDownButton.bottomAnchor.constraint(equalTo: descriptionFilmLabel.bottomAnchor),
            chevronDownButton.leftAnchor.constraint(equalTo: descriptionFilmLabel.rightAnchor, constant: 1),
        ])
    }

    @objc private func toggleDescriptionHeight() {
        print("Tap")
        // Рассчитываем размер содержимого
        let expectedSize = descriptionFilmLabel.sizeThatFits(CGSize(
            width: descriptionFilmLabel.frame.width,
            height: CGFloat.greatestFiniteMagnitude
        ))
        // Меняем констрейнт
        descriptionFilmLabelHeightConstraint?.constant = isLabelExpanded ? 100 : expectedSize.height
        // Анимируем изменения
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        // Меняем флаг состояния
        isLabelExpanded.toggle()

        // Обновляем высоту лейбла в ViewController
        if let tableView = superview as? UITableView,
           var indexPath = tableView.indexPath(
               for: self
           )
        {
            (tableView.delegate as? DetailsFilmViewController)?.detailedDescriptionLabelHeight = currentLabelHeight
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

// swiftlint:enable all
