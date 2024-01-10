//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Rabia Abdioğlu on 10.01.2024.
//


import XCTest
@testable import Weather

class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!

    override func setUpWithError() throws {
        viewModel = WeatherViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchData() throws {
        // Given
        let expectation = expectation(description: "Weather data should be fetched")

        // When
        viewModel.fetchData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(!self.viewModel.weatherData.isEmpty, "Weather data should not be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testAddFavoriteCity() throws {
        // Given
        let city = WeatherModel(id: 1,
                                city: "TestCity",
                                country: "TestCountry",
                                latitude: 0,
                                longitude: 0,
                                temperature: 25,
                                weather_description: "TestWeather",
                                humidity: 50,
                                wind_speed: 10,
                                forecast: [])

        // When
        viewModel.addFavoriteCity(city: city)

        // Then
        XCTAssertTrue(viewModel.favoriteCities.contains { $0.name == "TestCity" && $0.country == "TestCountry" }, "Favorite cities should contain the added city")
    }



}
