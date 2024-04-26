// CastAndCrewCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
class CastAndCrewCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let nameFont = "Verdana"
    }

    // MARK: - Visual Components

    private let photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: Constants.nameFont, size: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPhotoImageViewConstraint()
        setupPersonNameLabelConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPhotoImageViewConstraint()
        setupPersonNameLabelConstraint()
    }

    // MARK: - Public Methods

    func configurePersonPhoto(photo: String) {
        photoImageView.downloaded(from: photo)
    }

    func configurePersonName(name: String) {
        personNameLabel.text = name
    }

    // MARK: - Private Methods

    private func setupPhotoImageViewConstraint() {
        contentView.addSubview(photoImageView)

        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 46),
            photoImageView.heightAnchor.constraint(equalToConstant: 73)
        ])
    }

    private func setupPersonNameLabelConstraint() {
        contentView.addSubview(personNameLabel)

        NSLayoutConstraint.activate([
            personNameLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            personNameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 1),
            personNameLabel.widthAnchor.constraint(equalToConstant: 60),
            personNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
