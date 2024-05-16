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
        GeometryReader { geometry in
            ZStack {
                Image(viewModel.isMorning ? "Day" : "Night")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let weatherData = viewModel.weather {
                        TopSectionView(location: weatherData.location, current: weatherData.current)
                        Spacer()
                        
                        BottomSectionView(current: weatherData.current)
                        
                    } else {
                        ProgressView("Fetching Weather Data...")
                            .font(Font.title2)
                            .foregroundColor(.white)
                    }
                }
            

                .padding()
            }
        }
        .onAppear {
            viewModel.requestLocationPermission()
            viewModel.startTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
