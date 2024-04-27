// StateView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояние загрузки
enum StateView {
    /// инициализация
    case initial
    /// загрузка
    case loading
    /// данные пришли
    case success([FilmsCommonInfo])
    /// ошибка
    case failure
}
