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
    let day: ForecastDay
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(location.name)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(viewModel.textColor)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                VStack {
                    Text(current.condition.text)
                        .font(.title3)
                        .foregroundColor(viewModel.textColor)
                    
                    HStack {
                        Text("H: \(Int(day.day.maxtemp_c))°")
                            .foregroundColor(viewModel.textColor)
                        Text("L: \(Int(day.day.mintemp_c))°")
                            .foregroundColor(viewModel.textColor)
                    }
                }
                
                KFImage(URL(string: "https:\(current.condition.icon)"))
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("\(Int(current.temp_c))°")
                    .font(.system(size: 40))
                    .fontWeight(.thin)
                    .foregroundColor(viewModel.textColor)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
}

struct TopSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let forecastDay = ForecastDay(date: "2024-05-16", day: Day(maxtemp_c: 20, mintemp_c: 10, condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")), hour: [])
        let viewModel = WeatherViewModel()
        TopSectionView(location: Location(name: "Madinat Sittah Uktubar"),
                       current: CurrentWeather(temp_c: 21.0, condition: Condition(text: "Partly Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"), feelslike_c: 16.0, humidity: 36, pressure_mb: 1021.0),
                       day: forecastDay,
                       viewModel: viewModel)
    }
}
