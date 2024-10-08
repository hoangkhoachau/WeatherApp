//
//  ContentViewModel.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 12/07/2024.
//

import SwiftUI

@MainActor final class ContentViewModel: ObservableObject {
    
    // MARK: City Variables
    var cityName: String = "" // User for navigation bar title
    @Published var city: City = .tempCity {
        didSet {
            self.updateCityName()
        }
    }
    
    // MARK: Sheets Variables
    @Published var isShowingCitiesView = false
    @Published var isShowingSettingsView = false
    
    // MARK: Network Alert Variables
    @Published var isShowingNetworkAlert = false
    let networkAlertTitle = "Network error"
    let networkAlertMessage = "Looks like we’re having some trouble connecting to our servers. No worries, let’s check your internet connection and try again"
    
    // The function checks if there are cities are saved locally it fetch them if not...
    // The function checks if location services is allowed it fetch current location if not...
    // It shows add city sheet that dismissed only when the user add a city
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
