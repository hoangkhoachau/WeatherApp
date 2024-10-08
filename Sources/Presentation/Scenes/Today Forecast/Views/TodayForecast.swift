//
//  TodayForecast.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

struct TodayForecast: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.layoutDirection) var layoutDirection
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Binding var city: City
    @StateObject private var viewModel = TodayForecastViewModel()
    @EnvironmentObject var temperatureManager: TemperatureManager
    
    private var isScreenPortrait: Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return verticalSizeClass != .compact
        } else {
            return horizontalSizeClass == .compact && verticalSizeClass == .regular
        }
    }
    
    var body: some View {
        Group {
            if isScreenPortrait {
                VStack {
                    mainView
                }
            } else {
                HStack {
                    mainView
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding()
        .background(.primary.opacity(0.1))
        .background(Color.forecastBackground(weatherId: viewModel.weatherId).gradient)
        .onAppear {
            viewModel.fetchForecast(for: city)
        }
        .onChange(of: city) { newValue in
            viewModel.fetchForecast(for: newValue)
        }
    }

    @ViewBuilder private var mainView: some View {
        headerSection
        Spacer()
        VStack(spacing: 16) {
            forecastInfoHeader
            
            forecastInfoGrid
            
            Divider()
            
            hourlyForecastInfo
        }
        .padding()
        .background(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
        .cornerRadius(12)
        .frame(maxWidth: isScreenPortrait ? .infinity : UIScreen.screenWidth/2)
    }
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top) {
                Text(temperatureManager.getTemperature(viewModel.temperature).description)
                    .font(.system(size: 80, design: .rounded))
                    .fontWeight(.bold)
                
                Text("°")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .offset(x: -8)
            }
            .padding(.trailing, -24)
            .environment(\.layoutDirection, .leftToRight)
            
            Text(viewModel.description)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(viewModel.date, formatter: DateFormatter.dateFormatter)
                .font(.headline)
        }
        .foregroundStyle(.ultraThickMaterial)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    private var forecastInfoHeader: some View {
        HStack {
            Text(String(localized: "today"))
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            NavigationLink {
                DailyForecast(dailyForecast: viewModel.dailyForecast)
            } label: {
                HStack {
                    Text(String(localized: "dailyForecast"))
                    Image(systemName: "chevron.\(layoutDirection == .leftToRight ? "right" : "left")")
                }
                .font(.headline)
            }
        }
    }
    
    private var forecastInfoGrid: some View {
        LazyVGrid(columns: viewModel.forecastInfoGridColumns) {
            ForecastInfoItem(forecastInfo: .wind, title: viewModel.windSpeed)
            ForecastInfoItem(forecastInfo: .feelsLike, title: viewModel.feelsLike)
            ForecastInfoItem(forecastInfo: .humidity, title: viewModel.humidity)
            ForecastInfoItem(forecastInfo: .pressure, title: viewModel.pressure)
        }
    }
    
    private var hourlyForecastInfo: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.hourlyForecast, id: \.dt) { hour in
                    HourlyForecastItem(currentHourForcast: hour)
                }
            }
        }
    }
}

struct TodayForecast_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodayForecast(city: .constant(.tempCity))
                .environmentObject(TemperatureManager())
                .environment(\.locale, .init(identifier: "ar"))
        }
    }
}
