//
//  DailyForecast.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 12/07/2024.
//

import SwiftUI

struct DailyForecast: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let dailyForecast: [Daily]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(dailyForecast, id: \.dt) { forecast in
                DailyForecastCardItem(forecast: forecast)
            }
        }
        .navigationTitle(String(localized: "dailyForecast"))
        .background(colorScheme == .dark ? Color(UIColor.systemGray5) : Color(UIColor.systemGray6))
    }
}

struct DailyForecast_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecast(dailyForecast: [])
    }
}
