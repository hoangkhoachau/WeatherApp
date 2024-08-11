//
//  ForecastInfoItem.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import SwiftUI

struct ForecastInfoItem: View {
    
    let forecastInfo: ForecastInfo
    
    var body: some View {
        HStack {
            Image(systemName: forecastInfo.icon)
                .font(.title)
                .fontWeight(.semibold)
                .padding(8)
                .background(Color(UIColor.systemGray6))
                .foregroundStyle(forecastInfo.color)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(forecastInfo.rawValue.capitalized)
                    .font(.headline)
                
                Text("6.69 km/h") // TODO: Update Model
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ForecastInfoItem_Previews: PreviewProvider {
    static var previews: some View {
        ForecastInfoItem(forecastInfo: .wind)
    }
}
