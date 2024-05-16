//
//  TopSectionView.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import SwiftUI
import Kingfisher

struct TopSectionView: View {
    let location: Location
    let current: CurrentWeather
    
    var body: some View {
        VStack {
            Text(location.name)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
          
            
            HStack {
                VStack {
                    Text(current.condition.text)
                        .font(.title3)
                        .foregroundColor(.black)
                    
                    HStack {
                        Text("H: \(Int(current.temp_c))°")
                            .foregroundColor(.black)
                        Text("L: \(Int(current.feelslike_c))°")
                            .foregroundColor(.black)
                    }
                }
                
                KFImage(URL(string: "https:\(current.condition.icon)"))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.black)
                Text("\(Int(current.temp_c))°")
                    .font(.system(size: 40))
                    .fontWeight(.thin)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
}

struct TopSectionView_Previews: PreviewProvider {
    static var previews: some View {
        TopSectionView(location: Location(name: "Madinat Sittah Uktubar"),
                       current: CurrentWeather(temp_c: 21.0, condition: Condition(text: "Partly Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"), feelslike_c: 16.0, humidity: 36, pressure_mb: 1021.0))
    }
}
