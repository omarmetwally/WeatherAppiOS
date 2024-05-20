//
//  BottomSectionView.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import SwiftUI

struct BottomSectionView: View {
    let current: CurrentWeather
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible()), count: 2),
            alignment: .center,
            spacing: 20
        ) {
            BottomDetailView(title: "VISIBILITY", value: "10 km", textColor: viewModel.textColor)
            BottomDetailView(title: "HUMIDITY", value: "\(current.humidity)%", textColor: viewModel.textColor)
            BottomDetailView(title: "FEELS LIKE", value: "\(current.feelslike_c)°", textColor: viewModel.textColor)
            BottomDetailView(title: "PRESSURE", value: "\(current.pressure_mb) hPa", textColor: viewModel.textColor)
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
}

struct BottomDetailView: View {
    var title: String
    var value: String
    var textColor: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(textColor)
            
            Text(value)
                .font(.title)
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BottomSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeatherViewModel()
        BottomSectionView(current: CurrentWeather(temp_c: 21.0, condition: Condition(text: "Partly Cloudy", icon: ""), feelslike_c: 16.0, humidity: 36, pressure_mb: 1021.0), viewModel: viewModel)
    }
}
