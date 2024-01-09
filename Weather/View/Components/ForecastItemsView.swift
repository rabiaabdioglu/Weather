//
//  ForecastItemsView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 9.01.2024.
//

import SwiftUI

struct ForecastItemsView: View {
    
    var temp : Double
    var description : String
    var humidity : Double
    var wind : Double

    
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Spacer()
                Text("Today")
                    .padding(10)

                Spacer()
            }
            HStack{
                Text(String(format: "%.2f °C", temp))
                    .padding(10)

                Spacer()
                Image(systemName: WeatherAssets.weatherIcon(weather_description: description))
                    .foregroundColor(Color.yellow)
                    .padding(10)
            }
            HStack{
                Text(String(format: "%.2f %", humidity))
                    .padding(10)
                Spacer()
                Image(systemName: "humidity.fill")
                    .padding(10)
            }
            HStack{
                Text(String(format: "%.2f km/s", wind))
                    .padding(10)
                Spacer()
                Image(systemName: "wind" )
                    .padding(10)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .padding(10)
        .background(.separator)
    }
}

#Preview {
    ForecastItemsView(temp: 20, description: "sunny", humidity: 70, wind: 80)
}
