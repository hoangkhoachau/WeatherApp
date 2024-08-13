//
//  City.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Foundation

struct City: Codable, Hashable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

extension City {
    static var tempCity: City {
        .init(name: "Add your city", localNames: [
            "ar": "أضف مدينتك",
            "en": "Add your city"
        ], lat: 0, lon: 0, country: nil, state: nil)
    }
}
