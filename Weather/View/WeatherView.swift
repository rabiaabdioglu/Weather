//
//  WeatherView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import SwiftUI


struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.weatherData, id: \.id) { weather in
                NavigationLink(destination: WeatherDetailsView(weatherData: weather)) {
                    Text("\(weather.city), \(weather.country)")
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .navigationBarTitle("Weather App")
        }
    }
}

#Preview {
    WeatherView()
}
