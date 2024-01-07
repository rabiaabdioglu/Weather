//
//  FavoriteCityModel.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import Foundation

struct FavoriteCity: Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let weatherData: WeatherModel
}
