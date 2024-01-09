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
    @Published var weatherData: [WeatherModel] = []
    @Published var favoriteCities: [FavoriteCity] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchData() {
        // Çevrimdışı kontrolü
        if !NetworkReachabilityManager.default!.isReachable {
            if let cachedData = loadCachedData() {
                // Cache'den veriyi yükle
                self.weatherData = cachedData
                return
            } else {
                print("No cached data available.")
            }
        } else {
            // Çevrimiçi ise API'den veriyi çek
            guard let url = URL(string: "https://freetestapi.com/api/v1/weathers") else {
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
                    self?.weatherData = data
                    self?.saveDataToLocal(data)
                })
                .store(in: &cancellables)
        }
    }
    
    private func saveDataToLocal(_ data: [WeatherModel]) {
        if let data = try? JSONEncoder().encode(data) {
            guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("cachedData.json") else { return }
            try? data.write(to: fileURL)
        }
    }
    
    
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
}
