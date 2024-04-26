// StateView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
enum StateView {
    case initial
    case loading
    case success([FilmsCommonInfo])
    case failure
}
