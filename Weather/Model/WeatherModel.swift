//
//  WeatherModel.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import Foundation


struct Forecast :  Codable , Hashable {
    var date: String
    var temperature: Double
    var weather_description: String
    var humidity: Double
    var wind_speed: Double
}

struct WeatherModel : Codable ,Hashable {
    var id: Int
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
    var temperature: Double
    var weather_description: String
    var humidity: Double
    var wind_speed: Double
    var forecast: [Forecast]
}
