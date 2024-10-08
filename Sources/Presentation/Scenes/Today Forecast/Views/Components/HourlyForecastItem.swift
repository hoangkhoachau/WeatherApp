//
//  HourlyForecastItem.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

struct HourlyForecastItem: View {
    
    @EnvironmentObject var temperatureManager: TemperatureManager
    
    var currentHourForcast: Current
    
    var body: some View {
        VStack(spacing: -4) {
            Text(currentHourForcast.dt, formatter: DateFormatter.timeFormatter)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            ForecastIcon(icon: currentHourForcast.weather.first?.icon ?? "10d")
            
            Text("\(Int(temperatureManager.getTemperature(currentHourForcast.temp)).description)°")
                .font(.headline)
        }
        .padding(.horizontal, 8)
    }
}

