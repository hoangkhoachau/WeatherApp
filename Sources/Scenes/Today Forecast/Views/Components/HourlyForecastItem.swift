//
//  HourlyForecastItem.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

struct HourlyForecastItem: View {
    
    var currentHourForcast: Current
    
    var body: some View {
        VStack(spacing: -4) {
            Text(currentHourForcast.dt, formatter: DateFormatter.timeFormatter)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            ForecastIcon(icon: currentHourForcast.weather.first?.icon ?? "10d", frameSize: 60)
                .shadow(color: .secondary.opacity(0.75), radius: 1)
            
            Text("\(Int(currentHourForcast.temp).description)°")
                .font(.headline)
        }
        .padding(.horizontal, 8)
    }
}

