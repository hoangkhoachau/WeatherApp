//
//  WeatherLocal.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 13/07/2024.
//

import Foundation

struct WeatherLocal {
    static var language: String {
        (Locale.current.language.languageCode!.identifier) == "ar" ? "ar" : "en"
    }
}
