//
//  WeatherAPI.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Combine
import SwiftUI

struct WeatherAPI {
    static func fetchWeatherData(lat: Double, lon: Double) -> AnyPublisher<Forecast, Error> {
        
        let language = WeatherLocal.language
        
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(API.key)&lang=\(language)") else {
            print("DEBUG: Invalid weather URL,")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap(getData)
            .decode(type: Forecast.self, decoder: JSONDecoder())
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
