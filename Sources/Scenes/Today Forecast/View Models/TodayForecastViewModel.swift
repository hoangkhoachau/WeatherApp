//
//  TodayForecastViewModel.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Combine
import SwiftUI

@MainActor final class TodayForecastViewModel: ObservableObject {
    
    @Published private var forecast: Forecast?
    
    private var cancellables: Set<AnyCancellable> = []
    let forecastInfoGridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    
    func fetchForecast(for city: City) {
        WeatherAPI.fetchWeatherData(lat: city.lat, lon: city.lon)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("DEBUG: Weather data was fetched successfully.")
                    return
                    
                case .failure(let error):
                    print("DEBUG: Failed to fetch weather,", error)
                    
                }
            } receiveValue: { [weak self] fetchedForecast in
                self?.forecast = fetchedForecast
            }
            .store(in: &cancellables)
    }
}

// MARK: - Data Formatter
extension TodayForecastViewModel {
    var temperature: String {
        "\(Int(forecast?.current.temp ?? 0))"
    }
    
    var date: Date {
        forecast?.current.dt ?? .now
    }
    
    var description: String {
        forecast?.current.weather.first?.description.capitalized ?? "Unkown"
    }
    
    var windSpeed: String {
        "\(forecast?.current.windSpeed ?? 0) km/h"
    }
    
    var feelsLike: String {
        "\(forecast?.current.feelsLike ?? 0)°"
    }
    
    var humidity: String {
        "\(forecast?.current.humidity ?? 0)%"
    }
    
    var pressure: String {
        "\(forecast?.current.pressure ?? 0) hPa"
    }
    
    var hourlyForecast: [Current] {
        forecast?.hourly ?? []
    }
}
