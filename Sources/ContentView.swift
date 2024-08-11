//
//  ContentView.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager.shared
    
    var body: some View {
        NavigationStack {
            TodayForecast()
                .onAppear {
                    locationManager.checkLocationAuthorization()
                }
                .sheet(isPresented: $locationManager.servicesIsDenied) {
                    Text("Hello, world!")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
