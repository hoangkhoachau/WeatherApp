//
//  ForecastInfo.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

enum ForecastInfo: String {
    case wind
    case feelsLike = "Feels Like"
    case humidity
    case pressure
}

extension ForecastInfo {
    var icon: String {
        switch self {
        case .wind:
            return "wind"
        case .feelsLike:
            return "sparkles"
        case .humidity:
            return "humidity"
        case .pressure:
            return "gauge.medium"
        }
    }
}

extension ForecastInfo {
    var color: Color {
        switch self {
        case .wind:
            return .blue
        case .feelsLike:
            return .green
        case .humidity:
            return .orange
        case .pressure:
            return .indigo
        }
    }
}
