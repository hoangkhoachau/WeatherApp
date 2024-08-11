//
//  LocationManager.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import CoreLocation
import Foundation

class LocationManager: ObservableObject {
    
    private let manager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    @Published var servicesIsDenied: Bool = true
    
    static let shared = LocationManager()
    private init() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        self.servicesIsDenied = false
        
        switch manager.authorizationStatus{
            
        case .notDetermined:
            self.servicesIsDenied = true
            manager.requestWhenInUseAuthorization()
            
        case .denied:
            self.servicesIsDenied = true
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            self.userLocation = manager.location
            
        default:
            break
            
        }
    }
}
