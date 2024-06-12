// CinemaStarMVVMTests.swift
// Copyright © RoadMap. All rights reserved.

// swiftlint: disable all

@testable import CinemaStarMVVM
import XCTest

final class CinemaStarMVVMTests: XCTestCase {
    var networkService: NetworkServiceProtocol!
    var listFilmsViewModel: ListFilmViewModel!
    var listFilmsCoordinator: ListFilmsCoordinator!

    override func setUpWithError() throws {
        networkService = NetworkService()
        listFilmsViewModel = ListFilmViewModel(
            listFilmsCoordinator: listFilmsCoordinator,
            networkService: networkService
        )
    }

    override func tearDownWithError() throws {
        networkService = nil
        listFilmsViewModel = nil
    }

    func testExample() throws {
        let expectation = XCTestExpectation()
        networkService.getFilms { result in

            switch result {
            case .failure:
                expectation.fulfill()
            case let .success(films):
                XCTAssertNotNil(films)
                expectation.fulfill()
            }
        }
        wait(for: [expectation])
    }
}

// swiftlint: enable all
