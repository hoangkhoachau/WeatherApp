//
//  TodayForecast.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

struct TodayForecast: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var city: City
    @StateObject private var viewModel = TodayForecastViewModel()
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var screenWidth: Double {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.screen.bounds.size.width
        }
        
        return 200
    }
    
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
        .frame(maxWidth: isScreenPortrait ? .infinity : screenWidth/2)
    }
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top) {
                Text(viewModel.temperature)
                    .font(.system(size: 80, design: .rounded))
                    .fontWeight(.bold)
                
                Text("°")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .offset(x: -8)
            }
            .padding(.trailing, -24)
            
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
            Text("Today's")
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            NavigationLink {
                DailyForecast(dailyForecast: viewModel.dailyForecast)
            } label: {
                HStack {
                    Text("Daily Forecast")
                    Image(systemName: "chevron.right")
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
            TodayForecast(city: .constant(City(name: "Cairo", lat: 30, lon: 30)))
        }
    }
}
