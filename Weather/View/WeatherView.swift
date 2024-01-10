//
//  WeatherView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import SwiftUI

struct WeatherView: View {
    // Observable object to manage weather data
    @ObservedObject var viewModel = WeatherViewModel()
    // State variable to keep track of the selected tab
    @State private var selectedTab: Int = 0
    // Search text for filtering the list
    @State var searchText = ""
    // Computed property to filter weather data based on search text
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
                if viewModel.weatherData.count == 0{
                    VStack{
                        Spacer()
                        Text("Please make sure you have an internet connection .")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                
                // List of weather data with navigation links
     
                ScrollViewReader { scrollView in
                    ZStack(alignment: .bottomTrailing){
                        List {
                            ForEach(filteredTasks, id: \.self) { weather in
                                NavigationLink(destination: WeatherDetailsView(weatherData: weather)) {
                                    ListItemsView(weatherData: weather)
                                        .background(Color.clear)
                                        .listRowBackground(Color.clear)
                                        .id(weather.id)
                                }
                                .padding(15)
                                .buttonStyle(PlainButtonStyle())
                                .onAppear {
                                    if viewModel.weatherData.last == weather {
                                        viewModel.fetchData()
                                    }
                                }
                            }
                            .background(.separator)
                            .listRowSeparator(.hidden)
                            .background(Color.clear)
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        
                        if filteredTasks.count != 0{
                            // Scroll to Top Button
                            Button(action: {
                                
                                scrollView.scrollTo(filteredTasks.first!, anchor: .bottom)
                            }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.white)
                            }
                            .background(Color.secondary)
                            .clipShape(Circle())
                            .padding(20)
                        }}
                }
                
            }
            .onAppear {
                // Fetch weather data when the view appears
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
        .foregroundColor(.gray)
    }
}

#Preview {
    WeatherView()
}
