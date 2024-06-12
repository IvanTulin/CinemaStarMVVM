// FavoritesService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для работы с фаворитам
class FavoritesService {
    func saveFavoriteMovie(movieId: Int) {
        UserDefaults.standard.set(movieId, forKey: "favoriteMovieId")
    }

    func loadFavoriteMovie() -> Int? {
        UserDefaults.standard.integer(forKey: "favoriteMovieId")
    }
}
