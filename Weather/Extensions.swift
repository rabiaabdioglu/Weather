//
//  Extensions.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import Foundation
import SwiftUI



class WeatherAssets{
    
    
    static func weatherIcon(weather_description : String) -> String {
        switch weather_description.lowercased() {
        case "sunny":
            return "sun.max.fill"
        case "partly cloudy":
            return "cloud.sun.fill"
        case "clear sky":
            return "sun.min.fill"
        case "cloudy":
            return "cloud.fill"
        case "rainy":
            return "cloud.rain.fill"
        case "rain":
            return "cloud.rain.fill"
        case "rain showers":
            return "cloud.heavyrain.fill"
        case "scattered clouds":
            return "smoke.fill"
        default:
            return "questionmark.diamond.fill"
        }
    }
}


// Preview eklentisi burada...

extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: Double(red), green: Double(green), blue: Double(blue))
    }
}
