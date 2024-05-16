//
//  TopSectionView.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import SwiftUI

struct TopSectionView: View {
    let location: Location
    let current: CurrentWeather
    
    var body: some View {
        VStack {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("\(Int(current.temp_c))°")
                .font(.system(size: 80))
                .fontWeight(.thin)
                .foregroundColor(.black)

            Text(current.condition.text)
                .font(.title3)
                .foregroundColor(.black)

            HStack {
                Text("H: \(Int(current.temp_c))°")
                    .foregroundColor(.black)
                Text("L: \(Int(current.feelslike_c))°")
                    .foregroundColor(.black)
            }
            
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
}

struct TopSectionView_Previews: PreviewProvider {
    static var previews: some View {
        TopSectionView(location: Location(name: "Cairo"),
                       current: CurrentWeather(temp_c: 21.0, condition: Condition(text: "Partly Cloudy", icon: ""), feelslike_c: 16.0, humidity: 36, pressure_mb: 1021.0))
    }
}
