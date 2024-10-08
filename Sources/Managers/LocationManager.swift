//
//  LocationManager.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject {
    
    private let manager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    static let shared = LocationManager()
    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func checkLocationAuthorization() {
        switch manager.authorizationStatus{
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .denied:
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            self.userLocation = manager.location
            
        default:
            break
            
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
