//
//  HomeView.swift
//  Weather
//
//  Created by Rabia Abdioğlu on 8.01.2024.
//

import SwiftUI

// HomeView.swift
struct HomeView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                WeatherView()
                    .tabItem {
                        Label("Home", systemImage: "cloud.sun.rain.fill")
                    }
                FavoriteCitiesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.light, for: .tabBar)
            .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
            .tint(Color(red: 0.389, green: 0.549, blue: 0.846))
        }  .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = .separator
            UITabBar.appearance().tintColor = UIColor(Color(hex: "#648CD1"))
            UITabBar.appearance().barTintColor = .white
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .background(.pink)
    }
}
