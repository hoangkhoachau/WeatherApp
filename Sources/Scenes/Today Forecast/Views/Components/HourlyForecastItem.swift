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
        VStack(spacing: 8) {
            Text(currentHourForcast.dt, formatter: DateFormatter.timeFormatter)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Image(systemName: "wind.circle.fill")
                .font(.largeTitle)
            
            Text("\(Int(currentHourForcast.temp).description)°")
                .font(.headline)
        }
        .padding(.horizontal, 8)
    }
}

