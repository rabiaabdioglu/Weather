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
        NavigationStack{
            Spacer()
            
            VStack(alignment: .center){
                VStack() {
                    Text(weatherData.city)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text(weatherData.country)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    HStack{
                        Image(systemName: "mappin")
                            .imageScale(.small)
                        Text(String(format: "%.3f°", weatherData.latitude))
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text(String(format: ", %.3f°", weatherData.longitude))
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    Text(String(format: "%.f °C", weatherData.temperature))
                        .fontWeight(.ultraLight)
                        .font(.system(size: 70))
                        .padding(.top, 40)
                    
                }
                .padding()
                //FORECAST
                ScrollView(.horizontal) {
                    LazyHStack {
                        //ForecastItemsView kod tekrarını önlemek için
                        ForecastItemsView(temp: weatherData.temperature, description: weatherData.weather_description, humidity: weatherData.humidity, wind: weatherData.wind_speed)
                            .padding(.leading, 20)
                        Spacer()
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
                .scrollIndicators(.visible)
                .font(.title3)
                
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
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        
        
        
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
