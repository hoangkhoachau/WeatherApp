//
//  WeatherApp.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    // MARK: Dark Mode Configurations
    @StateObject private var colorSchemeManager = ColorSchemeManager()
    @AppStorage("SchemeType") private var schemeType: SchemeType = .unspecified
    
    // MARK: Temperature Degree Configurations
    @StateObject private var temperatureManager = TemperatureManager()
    
    // MARK: Network Configurations
    @StateObject var networkManager = NetworkManager()
    
    // MARK: Notification Configurations
    @StateObject var localNotificationManager = LocalNotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
                // Local Notification Manager
                .environmentObject(localNotificationManager)
            
                // Temperature Manager
                .environmentObject(temperatureManager)
            
                // Network Manager
                .environmentObject(networkManager)
            
                // Color Scheme Manager
                .environmentObject(colorSchemeManager)
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    colorSchemeManager.applyColorScheme()
                }
                .onChange(of: schemeType) { _ in
                    colorSchemeManager.applyColorScheme()
                }
        }
    }
}
