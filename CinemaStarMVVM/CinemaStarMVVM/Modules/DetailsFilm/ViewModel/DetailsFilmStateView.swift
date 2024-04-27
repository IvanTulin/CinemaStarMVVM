// DetailsFilmStateView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояние загрузки для Экрана детайле фильма
enum DetailsFilmStateView {
    /// инициализация
    case initial
    /// загрузка
    case loading
    /// данные пришли
    case success(DetailsFilmCommonInfo)
    /// ошибка
    case failure
}
