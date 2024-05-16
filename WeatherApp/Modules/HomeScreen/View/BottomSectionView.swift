//
//  BottomSectionView.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import SwiftUI

struct BottomSectionView: View {
    let current: CurrentWeather
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                BottomDetailView(title: "VISIBILITY", value: "10 km")
                Spacer()
                BottomDetailView(title: "HUMIDITY", value: "\(current.humidity)%")
            }
            HStack {
                BottomDetailView(title: "FEELS LIKE", value: "\(current.feelslike_c)°")
                Spacer()
                BottomDetailView(title: "PRESSURE", value: "\(current.pressure_mb) hPa")
            }
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
}

struct BottomDetailView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
            
            Text(value)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct BottomSectionView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSectionView(current: CurrentWeather(temp_c: 21.0, condition: Condition(text: "Partly Cloudy", icon: ""), feelslike_c: 16.0, humidity: 36, pressure_mb: 1021.0))
    }
}
