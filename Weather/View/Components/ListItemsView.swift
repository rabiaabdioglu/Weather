//
//  ListItemsView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import SwiftUI

struct ListItemsView: View {
    var weatherData: WeatherModel
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                VStack(alignment: .leading){
                    Text(weatherData.city)
                        .fontWeight(.semibold)
                    Text(weatherData.country)
                        .font(.footnote)
                        .fontWeight(.light)
                    
                }
                Spacer()
                HStack{
                    Text(String(format: "%.2f°", weatherData.temperature))
                        .padding(10)
                         Image(systemName: WeatherAssets.weatherIcon(weather_description: weatherData.weather_description))
                        .padding(10)
                        .symbolRenderingMode(.multicolor)
                     }
             }
            
            .frame(height: 100)
            .foregroundStyle(.white)
            .font(.title2)
            
            
        }
        .font(.title)
        .foregroundStyle(.white)
        
    }
    
    
}
