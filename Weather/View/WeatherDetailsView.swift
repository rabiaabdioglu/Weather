//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import Foundation
import SwiftUI

struct WeatherDetailsView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    // Weather data to be displayed
    var weatherData: WeatherModel
    
    // Check if the city is already marked as a favorite
    var isFavorite: Bool {
        viewModel.favoriteCities.contains { $0.name == weatherData.city && $0.country == weatherData.country }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                // City name, country, and location information
                VStack() {
                    Text(weatherData.city)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text(weatherData.country)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    HStack {
                        Image(systemName: "mappin")
                            .imageScale(.small)
                        Text(String(format: "%.3f°", weatherData.latitude))
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text(String(format: ", %.3f°", weatherData.longitude))
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    // Current temperature
                    Text(String(format: "%.f °C", weatherData.temperature))
                        .fontWeight(.ultraLight)
                        .font(.system(size: 70))
                        .padding(.top, 40)
                }
                .padding()
                
                // Forecast section
                ScrollView(.horizontal) {
                    LazyHStack {
                        // Display the current weather conditions
                        ForecastItemsView(temp: weatherData.temperature, description: weatherData.weather_description, humidity: weatherData.humidity, wind: weatherData.wind_speed)
                            .padding(.leading, 20)
                        Spacer()
                        // Display forecast for upcoming days
                        ForEach(weatherData.forecast, id: \.self) { forecast in
                            ForecastItemsView(temp: forecast.temperature, description: forecast.weather_description, humidity: forecast.humidity, wind: forecast.wind_speed)
                            Spacer()
                        }
                    }
                    .padding(0)
                    .scrollTargetLayout()
                }
                .defaultScrollAnchor(.leading)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .font(.title3)
                
                Spacer()
                
                Button(action: {
                    if isFavorite {
                        // Find the index of the city in the favorites and remove it
                        if let index = viewModel.favoriteCities.firstIndex(where: { $0.name == weatherData.city && $0.country == weatherData.country }) {
                            viewModel.favoriteCities.remove(at: index)
                            viewModel.saveFavoriteCities()
                        }

                    } else {
                        viewModel.addFavoriteCity(city: weatherData)
                    }
                }) {
                    Text(isFavorite ? "Delete From Favorites" : "Add City to Favorites +")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.blue)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                }
            }
            .padding(.bottom, 60)
            .background(
                Image("cloudBG4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
            .font(.title)
            .foregroundColor(.white)
            .tint(.white)
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationBarTitle(Text(""), displayMode: .inline)
        }
    }

 
}
//
//// SwiftUI preview for WeatherDetailsView
//struct WeatherDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherDetailsView(weatherData: WeatherModel(id: 1,
//                                                     city: "New York",
//                                                     country: "United States",
//                                                     latitude: 40.7128,
//                                                     longitude: -74.006,
//                                                     temperature: 25,
//                                                     weather_description: "Sunny",
//                                                     humidity: 50,
//                                                     wind_speed: 10,
//                                                     forecast: [
//                                                        Forecast(date: "2023-07-28", temperature: 24, weather_description: "Partly cloudy", humidity: 55, wind_speed: 12),
//                                                        Forecast(date: "2023-07-29", temperature: 26, weather_description: "Sunny", humidity: 48, wind_speed: 9)
//                                                     ]))
//        .previewDevice("iPhone 12 Pro")
//    }
//}
