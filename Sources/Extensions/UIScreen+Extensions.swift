//
//  UIScreen+Extensions.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 13/07/2024.
//

import SwiftUI

extension UIScreen {
    static var screenWidth: Double {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.screen.bounds.size.width
        }
        
        return 200
    }
}
