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
            
            if viewModel.favoriteCities.count == 0{
                VStack{
                    Spacer()
                    Text("There are no cities at all..")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    Spacer()
                }
            }
            
            
            
            VStack(alignment: .center) {
                Text("Favorite Cities")
                    .font(.title2)
                    .padding(.all, 10.0)
                List {
                    ForEach(viewModel.favoriteCities) { favCity in
                        NavigationLink(destination: WeatherDetailsView(weatherData: favCity.weatherData)) {
                            ListItemsView(weatherData: favCity.weatherData)
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
            .onAppear(){
                viewModel.loadFavoriteCities()
            }
            .background(
                Image("cloudBG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitle(Text(""), displayMode: .inline)
            
        }
        .tint(.white)
        .foregroundColor(.white)
        
       
    }

  
}
