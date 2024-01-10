//
//  WeatherApp.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 7.01.2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear(){
                    UITabBar.appearance().backgroundColor = .white
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .lightGray
                    
                }
        }
        
    }
}
