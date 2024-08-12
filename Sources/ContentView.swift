//
//  ContentView.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @ObservedObject private var locationManager = LocationManager.shared
    
    var body: some View {
        NavigationStack {
            TodayForecast(city: $viewModel.city)
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $viewModel.isShowingCitiesView, onDismiss: {
                    viewModel.fetchCity(locationManager: locationManager)
                }) {
                    CitiesListView { city in
                        viewModel.city = city
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        cityNameButton
                    }
                }
                .onAppear {
                    viewModel.fetchCity(locationManager: locationManager)
                }
                .onChange(of: locationManager.userLocation) { _ in
                    viewModel.fetchCity(locationManager: locationManager)
                }
        }
    }
    
    private var cityNameButton: some View {
        Button {
            viewModel.isShowingCitiesView = true
        } label: {
            Text(viewModel.city.name)
                .font(.title3)
                .fontWeight(.semibold)
                .tint(Color(UIColor.systemBackground))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
