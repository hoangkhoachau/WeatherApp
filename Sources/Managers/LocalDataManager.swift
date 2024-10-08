//
//  LocalDataManager.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Foundation

enum DefaultKey: String {
case cities = "UserDefaultsCitiesKey"
}

struct LocalDataManager {
    
    static func loadCities() -> [City] {
        if let data = UserDefaults.standard.data(forKey: DefaultKey.cities.rawValue) {
            do {
                let cities = try JSONDecoder().decode([City].self, from: data)
                return cities
            } catch {
                print("DEBUG: Failed to load cities,", error)
            }
        }
        
        return []
    }
    
    static func saveCities(_ cities: [City]) {
        do {
            let encodedData = try JSONEncoder().encode(cities)
            UserDefaults.standard.set(encodedData, forKey: DefaultKey.cities.rawValue)
        } catch {
            print("DEBUG: Failed to save cities,", error)
        }
    }
    
}
