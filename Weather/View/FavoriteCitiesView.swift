//
//  FavoriteCitiesView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import SwiftUI

struct FavoriteCitiesView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.favoriteCities) { city in
                        NavigationLink(destination: WeatherDetailsView(weatherData: city.weatherData)) {
                            Text("\(city.name), \(city.country)")
                        }
                    }
                    .onDelete(perform: deleteFavoriteCity)
                }
                
                Button(action: {
                    // Show a modal or navigate to another view to add new favorite city
                }) {
                    Text("Add Favorite City")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Favorite Cities")
        }
    }
    
    private func deleteFavoriteCity(at offsets: IndexSet) {
        viewModel.favoriteCities.remove(atOffsets: offsets)
    }
}

struct FavoriteCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCitiesView(viewModel: WeatherViewModel())
    }
}
