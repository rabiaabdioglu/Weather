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
            VStack(alignment: .center) {
                Text("Weather App")
                    .font(.title2)
                    .padding(.all, 10.0)
                List {
                    ForEach(viewModel.weatherData, id: \.id) { weather in
                        NavigationLink(destination: WeatherDetailsView(weatherData: weather)) {
                            ListItemsView(weatherData: weather)
                                .background(Color.clear)
                                .listRowBackground(Color.clear)
                        }
                        .padding(15)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .background(.separator)
                    .listRowSeparator(.hidden)
                    .background(Color.clear)
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
            }
            .onAppear {
                viewModel.fetchData()
            }
            .background(
                Image("cloudBG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
            .font(.title)
            .foregroundColor(.white)
        }
    }
}


#Preview {
    WeatherView()
}

