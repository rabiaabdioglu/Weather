//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: [WeatherModel] = []
    @Published var favoriteCities: [FavoriteCity] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchData() {
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
            })
            .store(in: &cancellables)
    }
}
