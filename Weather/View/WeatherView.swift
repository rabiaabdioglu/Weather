//
//  WeatherView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @State private var selectedTab: Int = 0
    // Search text for the list
    @State  var searchText = ""
        
    var filteredTasks: [WeatherModel] {
        let lowercasedSearchText: String
        
        lowercasedSearchText = searchText.lowercased()
        
        guard !lowercasedSearchText.isEmpty else { return viewModel.weatherData }
        
        
        print(lowercasedSearchText)
        
        
        return viewModel.weatherData.filter { item in
            let propertiesToSearch: [String?] = [
                item.city , item.country  ]
            
            return propertiesToSearch.compactMap { $0?.lowercased() }.contains { $0.contains(lowercasedSearchText) }
        }
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
//                Text("Weather App")
//                    .font(.title2)
//                    .padding(.all, 10.0)
                List {
                    ForEach(filteredTasks, id: \.id) { weather in
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
            .navigationBarTitle(Text(""), displayMode: .inline)
            
        }
        .tint(.white)
        .searchable(text: $searchText, placement: .toolbar, prompt: "Search City")
        .disableAutocorrection(true)
        .foregroundColor(.white)
        .toolbarBackground(.red, for: .navigationBar)
        
    }
}


#Preview {
    WeatherView()
}

