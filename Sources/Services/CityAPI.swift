//
//  CityAPI.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Combine
import Foundation

struct CityAPI {
    static func fetchCity(for name: String) -> AnyPublisher<[City], Error> {
        let cityName = name.capitalized.replacingOccurrences(of: " ", with: "-")
        
        guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=1&appid=\(API.key)") else {
            print("DEBUG: Invalid weather URL,")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap(getData)
            .decode(type: [City].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private static func getData(data: Data, response: URLResponse) throws -> Data {
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
