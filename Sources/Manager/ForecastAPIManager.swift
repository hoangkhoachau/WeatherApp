//
//  ForecastAPIManager.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 12/07/2024.
//

import Combine
import Foundation

struct ForecastAPIManager {
    
    static private var cancellables: Set<AnyCancellable> = []
    
    static func fetchForecast(for city: City, completion: @escaping (Forecast) -> ()) {
        WeatherAPI.fetchWeatherData(lat: city.lat, lon: city.lon)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    return
                    
                case .failure(let error):
                    print("DEBUG: Failed to fetch weather,", error)
                    
                }
            } receiveValue: { fetchedForecast in
                completion(fetchedForecast)
            }
            .store(in: &cancellables)
    }
    
}
