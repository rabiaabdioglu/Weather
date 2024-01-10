//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import Combine
import Foundation
import Alamofire

class WeatherViewModel: ObservableObject {
    
    // Published properties for weather data and favorite cities
    @Published var weatherData: [WeatherModel] = []
    @Published var favoriteCities: [FavoriteCity] = []
    private var page = 0 // Başlangıç sayfa numarası
    // Set to hold Combine cancellables for memory management
    private var cancellables: Set<AnyCancellable> = []
    
    // Initializer to load favorite cities on ViewModel creation
    init() {
        loadFavoriteCities()
    }

    // Function to fetch weather data from API or cache
    func fetchData() {
        // Offline check
        if !NetworkReachabilityManager.default!.isReachable {
            // If offline and cached data is available, load from cache
            if let cachedData = loadCachedData() {
                self.weatherData = cachedData
                return
            } else {
                print("No cached data available.")
            }
        } else {
            // If online, fetch data from API
            guard let url = URL(string: "https://freetestapi.com/api/v1/weathers?page=\(page)") else {
                       return
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .tryMap { data in
                    do {
                        let decodedData = try JSONDecoder().decode([WeatherModel].self, from: data)
                        return decodedData
                    } catch {
                        throw error
                    }
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] data in
                    self?.weatherData.append(contentsOf: data)
                    self?.saveDataToLocal(data)
                    self?.page += 1 // Sayfayı güncelle
                })
                .store(in: &cancellables)
        }
    }
    
    // Function to save data to local cache
    private func saveDataToLocal(_ data: [WeatherModel]) {
        if let data = try? JSONEncoder().encode(data) {
            guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("cachedData.json") else { return }
            try? data.write(to: fileURL)
        }
    }
    
    // Function to load cached data from local storage
    private func loadCachedData() -> [WeatherModel]? {
        do {
            guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("cachedData.json"),
                  let data = try? Data(contentsOf: fileURL),
                  let decodedData = try? JSONDecoder().decode([WeatherModel].self, from: data) else {
                return nil
            }
            return decodedData
        }
    }
    
    // Function to add a city to the list of favorite cities
    func addFavoriteCity(city: WeatherModel) {
        let favoriteCity = FavoriteCity(name: city.city, country: city.country, weatherData: city)
        favoriteCities.append(favoriteCity)
        saveFavoriteCities()
    }

    // Function to save favorite cities to UserDefaults
    func saveFavoriteCities() {
        if let encodedData = try? JSONEncoder().encode(favoriteCities) {
            UserDefaults.standard.set(encodedData, forKey: "favoriteCities")
        }
    }

    // Function to load favorite cities from UserDefaults
    func loadFavoriteCities() {
        if let data = UserDefaults.standard.data(forKey: "favoriteCities"),
           let decodedCities = try? JSONDecoder().decode([FavoriteCity].self, from: data) {
            favoriteCities = decodedCities
        }
    }
}
