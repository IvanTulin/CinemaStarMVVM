// HandlerImage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Создаем тип для  кложуры при загрузке Изображения
typealias HandlerImage = (Result<Data, ImageLoadingError>) -> ()
