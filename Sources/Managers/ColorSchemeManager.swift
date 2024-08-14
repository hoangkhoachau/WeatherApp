//
//  ColorSchemeManager.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 13/07/2024.
//

import SwiftUI

enum SchemeType: Int {
    case unspecified, light, dark
}

@MainActor final class ColorSchemeManager: ObservableObject {
    
    @AppStorage("SchemeType") var schemeType: SchemeType = .unspecified
    
    func applyColorScheme() {
        keyWindow?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: schemeType.rawValue)!
    }
    
    var keyWindow: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        
        return window
    }
}
