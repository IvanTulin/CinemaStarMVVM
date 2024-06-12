// ShimmerTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шиммера таблицы

final class ShimmerTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let imageShim = UIView()
    private let raitingShim = UIView()
    private let buttonShim = UIView()
    private let discriptionShim = UIView()
    private let countryShim = UIView()
    private let actorsLabelShim = UIView()
    private let actorsShim = UIView()
    private let langLabelShim = UIView()
    private let langShim = UIView()
    private let moreTitleShim = UIView()
    private let moreShim = UIView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupAnchors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupAnchors()
    }

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        imageShim.startShimmeringAnimation()
        raitingShim.startShimmeringAnimation()
        buttonShim.startShimmeringAnimation()
        discriptionShim.startShimmeringAnimation()
        countryShim.startShimmeringAnimation()
        actorsLabelShim.startShimmeringAnimation()
        actorsShim.startShimmeringAnimation()
        langLabelShim.startShimmeringAnimation()
        langShim.startShimmeringAnimation()
        moreTitleShim.startShimmeringAnimation()
        moreShim.startShimmeringAnimation()
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.addSubview(imageShim)
        contentView.addSubview(raitingShim)
        contentView.addSubview(buttonShim)
        contentView.addSubview(discriptionShim)
        contentView.addSubview(countryShim)
        contentView.addSubview(actorsLabelShim)
        contentView.addSubview(actorsShim)
        contentView.addSubview(langLabelShim)
        contentView.addSubview(langShim)
        contentView.addSubview(moreTitleShim)
        contentView.addSubview(moreShim)
    }

    private func setupAnchors() {
        setupAnchorsImageShip()
        setupAnchorsRaitingShim()
        setupAnchorsButtonShim()
        setupAnchorsDiscriptionShim()
        setupAnchorsCountryShim()
        setupAnchorsActorsLabelShim()
        setupAnchorsActorsShim()
        setupAnchorsLangLabelShim()
        setupAnchorsLangShim()
        setupAnchorsMoreTitleShim()
        setupAnchorsMoreShim()
    }

    private func setupAnchorsImageShip() {
        imageShim.translatesAutoresizingMaskIntoConstraints = false
        imageShim.layer.cornerRadius = 8
        imageShim.widthAnchor.constraint(equalToConstant: 170).isActive = true
        imageShim.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageShim.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsRaitingShim() {
        raitingShim.translatesAutoresizingMaskIntoConstraints = false
        raitingShim.layer.cornerRadius = 8
        raitingShim.widthAnchor.constraint(equalToConstant: 170).isActive = true
        raitingShim.heightAnchor.constraint(equalToConstant: 110).isActive = true
        raitingShim.leadingAnchor.constraint(equalTo: imageShim.trailingAnchor, constant: 16).isActive = true
        raitingShim.topAnchor.constraint(equalTo: imageShim.topAnchor, constant: 25).isActive = true
    }

    private func setupAnchorsButtonShim() {
        buttonShim.translatesAutoresizingMaskIntoConstraints = false
        buttonShim.layer.cornerRadius = 8
        buttonShim.widthAnchor.constraint(equalToConstant: 358).isActive = true
        buttonShim.heightAnchor.constraint(equalToConstant: 48).isActive = true
        buttonShim.topAnchor.constraint(equalTo: imageShim.bottomAnchor, constant: 16).isActive = true
        buttonShim.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    private func setupAnchorsDiscriptionShim() {
        discriptionShim.translatesAutoresizingMaskIntoConstraints = false
        discriptionShim.layer.cornerRadius = 8
        discriptionShim.widthAnchor.constraint(equalToConstant: 330).isActive = true
        discriptionShim.heightAnchor.constraint(equalToConstant: 100).isActive = true
        discriptionShim.topAnchor.constraint(equalTo: buttonShim.bottomAnchor, constant: 16).isActive = true
        discriptionShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsCountryShim() {
        countryShim.translatesAutoresizingMaskIntoConstraints = false
        countryShim.layer.cornerRadius = 8
        countryShim.widthAnchor.constraint(equalToConstant: 202).isActive = true
        countryShim.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countryShim.topAnchor.constraint(equalTo: discriptionShim.bottomAnchor, constant: 10).isActive = true
        countryShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsActorsLabelShim() {
        actorsLabelShim.translatesAutoresizingMaskIntoConstraints = false
        actorsLabelShim.layer.cornerRadius = 8
        actorsLabelShim.widthAnchor.constraint(equalToConstant: 202).isActive = true
        actorsLabelShim.heightAnchor.constraint(equalToConstant: 20).isActive = true
        actorsLabelShim.topAnchor.constraint(equalTo: countryShim.bottomAnchor, constant: 10).isActive = true
        actorsLabelShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsActorsShim() {
        actorsShim.translatesAutoresizingMaskIntoConstraints = false
        actorsShim.layer.cornerRadius = 8
        actorsShim.widthAnchor.constraint(equalToConstant: 350).isActive = true
        actorsShim.heightAnchor.constraint(equalToConstant: 97).isActive = true
        actorsShim.topAnchor.constraint(equalTo: actorsLabelShim.bottomAnchor, constant: 10).isActive = true
        actorsShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsLangLabelShim() {
        langLabelShim.translatesAutoresizingMaskIntoConstraints = false
        langLabelShim.layer.cornerRadius = 8
        langLabelShim.widthAnchor.constraint(equalToConstant: 202).isActive = true
        langLabelShim.heightAnchor.constraint(equalToConstant: 20).isActive = true
        langLabelShim.topAnchor.constraint(equalTo: actorsShim.bottomAnchor, constant: 10).isActive = true
        langLabelShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsLangShim() {
        langShim.translatesAutoresizingMaskIntoConstraints = false
        langShim.layer.cornerRadius = 8
        langShim.widthAnchor.constraint(equalToConstant: 202).isActive = true
        langShim.heightAnchor.constraint(equalToConstant: 20).isActive = true
        langShim.topAnchor.constraint(equalTo: langLabelShim.bottomAnchor, constant: 4).isActive = true
        langShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsMoreTitleShim() {
        moreTitleShim.translatesAutoresizingMaskIntoConstraints = false
        moreTitleShim.layer.cornerRadius = 8
        moreTitleShim.widthAnchor.constraint(equalToConstant: 202).isActive = true
        moreTitleShim.heightAnchor.constraint(equalToConstant: 20).isActive = true
        moreTitleShim.topAnchor.constraint(equalTo: langShim.bottomAnchor, constant: 10).isActive = true
        moreTitleShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    private func setupAnchorsMoreShim() {
        moreShim.translatesAutoresizingMaskIntoConstraints = false
        moreShim.layer.cornerRadius = 8
        moreShim.widthAnchor.constraint(equalToConstant: 170).isActive = true
        moreShim.heightAnchor.constraint(equalToConstant: 200).isActive = true
        moreShim.topAnchor.constraint(equalTo: moreTitleShim.bottomAnchor, constant: 8).isActive = true
        moreShim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
}
