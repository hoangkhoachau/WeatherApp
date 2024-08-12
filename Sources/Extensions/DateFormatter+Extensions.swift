//
//  DateFormatter+Extensions.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Foundation

extension DateFormatter {
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter
    }
}
