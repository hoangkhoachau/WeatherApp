//
//  DateFormatter+Extensions.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 11/07/2024.
//

import Foundation

extension DateFormatter {
    
    // Return time formate = 6 AM
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        formatter.amSymbol = String(localized: "am")
        formatter.pmSymbol = String(localized: "pm")
        
        return formatter
    }
    
    // Return date formate = June, 6
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        
        return formatter
    }
}
