//
//  TemperatureManager.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 13/07/2024.
//

import SwiftUI

enum DegreeType: String {
    case celsius, fahrenheit
}

@MainActor final class TemperatureManager: ObservableObject {
    @AppStorage("DegreeType") var degreeType: DegreeType = .celsius
    
    // Return temperature in Celsius/Fahrenheit based on user defaults
    func getTemperature(_ temperature: Double) -> Int {
        switch degreeType {
        case .celsius:
            return Int(temperature)
        case .fahrenheit:
            return Int((temperature * (9/5)) + 32)
        }
    }
}
