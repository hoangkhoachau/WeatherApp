//
//  CitiesListViewModel.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Combine
import Foundation

@MainActor final class CitiesListViewModel: ObservableObject {
    
    @Published var cities: [City] = []
    @Published var newCityName: String = "" // Used by textfield
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.cities = LocalDataManager.loadCities()
    }
    
    func addButtonPressed(completion: @escaping (City) -> ()) {
        CityAPI.fetchCity(for: newCityName)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    return
                    
                case .failure(let error):
                    print("DEBUG: City was not found,", error)
                }
            } receiveValue: { cities in
                if let fetchedCity = cities.first {
                    self.cities.insert(fetchedCity, at: 0)
                    self.newCityName = ""
                    self.saveCitiesLocally()
                    
                    completion(fetchedCity)
                }
            }
            .store(in: &cancellables)
    }
    
    // Called when user tap on city from history
    func updateCity(_ city: City) {
        guard let index = self.cities.firstIndex(where: { $0.lat == city.lat && $0.lon == city.lon }) else { return }
        self.cities.remove(at: index)
        self.cities.insert(city, at: 0)
        self.saveCitiesLocally()
    }
    
    func deleteCity(at offsets: IndexSet) {
        self.cities.remove(atOffsets: offsets)
        self.saveCitiesLocally()
    }
    
    func getCityName(_ city: City) -> String {
        let language = WeatherLocal.language
        return city.localNames?[language] ?? ""
    }
    
    private func saveCitiesLocally() {
        LocalDataManager.saveCities(self.cities)
    }
    
}
