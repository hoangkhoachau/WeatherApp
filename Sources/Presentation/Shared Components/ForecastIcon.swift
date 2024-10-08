//
//  ForecastIcon.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 12/07/2024.
//

import SwiftUI

struct ForecastIcon: View {
    let icon: String
    
    private var iconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
    
    var body: some View {
        AsyncImage(url: iconURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                
            case .failure:
                Image(systemName: "photo")
                    .foregroundColor(.secondary)
                
            @unknown default:
                fatalError()
            }
        }
        .frame(width: 50, height: 50)
        .shadow(color: .secondary.opacity(0.75), radius: 1)
    }
}
