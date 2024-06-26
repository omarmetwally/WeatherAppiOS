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
        NavigationView{
            GeometryReader { geometry in
                ZStack {
                    Image(viewModel.isMorning ? "Day" : "Night")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                    if let weatherData = viewModel.weather {
                        
                        VStack {
                            TopSectionView(location: weatherData.location, current: weatherData.current, day: weatherData.forecast.forecastday[0],viewModel: viewModel)
                            ForecastTableView(viewModel: viewModel, forecast: weatherData.forecast)
                            BottomSectionView(current: weatherData.current,viewModel: viewModel)
                        }
                        .padding()
                        
                    } else {
                        VStack {
                            ProgressView("Fetching Weather Data...")
                                .font(Font.title2)
                                .foregroundColor(viewModel.textColor)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }
            }
            .onAppear {
                viewModel.requestLocationPermission()
                viewModel.startTimer()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
