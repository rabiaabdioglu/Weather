//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import Foundation
import SwiftUI

struct WeatherDetailsView: View {
    var weatherData: WeatherModel
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                HStack(spacing : 50) {
                    Text(weatherData.city)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                .padding()
                Spacer()
                HStack {
                    Text(String(format: "%.f °C", weatherData.temperature))
                        .fontWeight(.ultraLight)
                        .font(.system(size: 80))
                }
                .padding(.top, 30)
                ScrollView(.horizontal) {
                    LazyHStack {
                        VStack(alignment: .center){
                            HStack{
                                Spacer()
                                Text("Today")
                                    .padding(10)
                                Spacer()
                            }
                            HStack{
                                Text(String(format: "%.2f °C", weatherData.temperature))
                                    .padding(10)
                                Spacer()
                                Image(systemName: WeatherAssets.weatherIcon(weather_description: weatherData.weather_description))
                                    .foregroundColor(Color.yellow)
                                    .padding(10)
                            }
                            HStack{
                                Text(String(format: "%.2f %", weatherData.humidity))
                                    .padding(10)
                                Spacer()
                                Image(systemName: "humidity.fill")
                                    .padding(10)
                            }
                            HStack{
                                Text(String(format: "%.2f km/s", weatherData.wind_speed))
                                    .padding(10)
                                Spacer()
                                Image(systemName: "wind" )
                                    .padding(10)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding(20)
                        .background(.separator)
                        .padding(.leading, 20)
                        Spacer()
                        ForEach(weatherData.forecast, id: \.self) { forecast in
                            VStack(alignment: .leading){
                                HStack{
                                    Spacer()
                                    Text(forecast.date)
                                        .padding(10)
                                    Spacer()
                                }
                                HStack{
                                    Text(String(format: "%.2f °C", forecast.temperature))
                                        .padding(10)
                                    Spacer()
                                    Image(systemName: WeatherAssets.weatherIcon(weather_description: forecast.weather_description))
                                        .foregroundColor(Color.yellow)
                                        .padding(10)
                                }
                                HStack{
                                    Text(String(format: "%.2f %", forecast.humidity))
                                        .padding(10)
                                    Spacer()
                                    Image(systemName: "humidity.fill")
                                        .padding(10)
                                }
                                HStack{
                                    Text(String(format: "%.2f km/s", forecast.wind_speed))
                                        .padding(10)
                                    Spacer()
                                    Image(systemName: "wind" )
                                        .padding(10)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .padding(20)
                            .background(.separator)
                            Spacer()
                        }
                    }
                    .padding(0)
                    .scrollTargetLayout()
                }
                .defaultScrollAnchor(.leading)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.visible)
                Spacer()
                Button(action: {
                    print("City added to favorites!")
                }) {
                    Text("Add City to Favorites   +  ")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.blue)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                }
                .padding()
            }
            .padding(.vertical, 40)
            .background(
                Image("cloudBG4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
            .font(.title)
            .foregroundColor(.white)
            .tint(.white)
        }
    }
    
}
struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(weatherData: WeatherModel(id: 1,
                                                     city: "New York",
                                                     country: "United States",
                                                     latitude: 40.7128,
                                                     longitude: -74.006,
                                                     temperature: 25,
                                                     weather_description: "Sunny",
                                                     humidity: 50,
                                                     wind_speed: 10,
                                                     forecast: [
                                                        Forecast(date: "2023-07-28", temperature: 24, weather_description: "Partly cloudy", humidity: 55, wind_speed: 12),
                                                        Forecast(date: "2023-07-29", temperature: 26, weather_description: "Sunny", humidity: 48, wind_speed: 9)
                                                     ]))
        .previewDevice("iPhone 12 Pro")
    }
}
