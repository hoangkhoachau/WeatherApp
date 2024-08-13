//
//  WeatherApp.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    // MARK: Dark Mode Variables
    @StateObject private var colorSchemeManager = ColorSchemeManager()
    @AppStorage("SchemeType") private var schemeType: SchemeType = .unspecified
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
                // Dark Mode Configurations
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
