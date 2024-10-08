//
//  DailyForecastCardItem.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 12/07/2024.
//

import SwiftUI

struct DailyForecastCardItem: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var temperatureManager: TemperatureManager
    
    let forecast: Daily
    private let forecastInfoGridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    
    private var temperature: String {
        temperatureManager.getTemperature(forecast.temp.day).description
    }
    
    private var windSpeed: String {
        "\(forecast.windSpeed) \(String(localized: "km/h"))"
    }
    
    private var feelsLike: String {
        "\(forecast.feelsLike.day)°"
    }
    
    private var humidity: String {
        "\(forecast.humidity)%"
    }
    
    private var pressure: String {
        "\(forecast.pressure) \(String(localized: "hpa"))"
    }
    
    // MARK: - Views
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ForecastIcon(icon: forecast.weather.first?.icon ?? "10d")
                
                VStack(alignment: .leading) {
                    Text(forecast.dt, formatter: DateFormatter.dateFormatter)
                        .font(.headline)
                    
                    Text(forecast.weather.first?.description ?? "Unknown")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                
                Spacer()
                
                HStack(alignment: .top) {
                    Text(temperature)
                        .font(.system(.title, design: .rounded, weight: .bold))
                    
                    Text("°")
                        .font(.headline)
                }
                .environment(\.layoutDirection, .leftToRight)
            }
            
            Divider()
            
            forecastInfoGrid
        }
        .padding()
        .background(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
        .cornerRadius(12)
        .padding()
    }
    
    private var forecastInfoGrid: some View {
        LazyVGrid(columns: forecastInfoGridColumns) {
            ForecastInfoItem(forecastInfo: .wind, title: windSpeed)
            ForecastInfoItem(forecastInfo: .feelsLike, title: feelsLike)
            ForecastInfoItem(forecastInfo: .humidity, title: humidity)
            ForecastInfoItem(forecastInfo: .pressure, title: pressure)
        }
    }
}
