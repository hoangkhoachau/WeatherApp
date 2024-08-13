//
//  ContentViewModel.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 12/07/2024.
//

import SwiftUI

@MainActor final class ContentViewModel: ObservableObject {
    
    @Published var city: City = .tempCity {
        didSet {
            self.updateCityName()
        }
    }
    
    @Published var isShowingCitiesView = false
    @Published var isShowingSettingsView = false
    
    var cityName: String = ""
    
    func fetchCity(locationManager: LocationManager) {
        let cities = LocalDataManager.loadCities()
        
        if !cities.isEmpty {
            self.city = cities.first!
            return
        }

        var coordinate: (lat: Double, lon: Double) = (0, 0)
        
        if let userLocation = locationManager.userLocation {
            coordinate.lat = userLocation.coordinate.latitude
            coordinate.lon = userLocation.coordinate.longitude
            
            self.city = City(name: "Current Location", localNames: [
                
                "en": "Current Location"
            ], lat: coordinate.lat, lon: coordinate.lon, country: nil, state: nil)
            
            self.isShowingCitiesView = false
            return
        }
        
        if city.lat != 0 && city.lon != 0 && !cities.isEmpty {
            self.isShowingCitiesView = false
            return
        }
        
        self.city = .tempCity
        self.isShowingCitiesView = true
    }
    
    private func updateCityName() {
        let language = WeatherLocal.language
        self.cityName = self.city.localNames?[language] ?? ""
    }
}
