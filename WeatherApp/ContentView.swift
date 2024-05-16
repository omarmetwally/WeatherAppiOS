//
//  ContentView.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            Image(Helper.isMorning() ? "Day" : "Night")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let weatherData = viewModel.weather {
                    TopSectionView(location: weatherData.location, current: weatherData.current)
                } else {
                    ProgressView("Fetching Weather Data...")
                        .font(Font.title2)
                }
            }
        }
        .onAppear {
            viewModel.requestLocationPermission()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
