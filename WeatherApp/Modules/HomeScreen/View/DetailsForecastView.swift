//
//  DetailsForecastView.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import SwiftUI
import Kingfisher

struct DetailsForecastView: View {
    let day: ForecastDay
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(viewModel.isMorning ? "Day" : "Night")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("\(viewModel.formatDate(day.date ,isFull: false)) Hourly Forecast")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .foregroundColor(viewModel.textColor)
                    
                    let hourlyForecasts = viewModel.filteredHourlyForecast(day: day)
                    
                    if hourlyForecasts.isEmpty {
                        VStack {
                            Text("It's the last hour in the day.")
                                .font(.title2)
                                .padding(.bottom, 10)
                            
                            Text("Go back to see the current temperature or other days.")
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List {
                            ForEach(hourlyForecasts, id: \.time) { hour in
                                HourlyForecastRow(hour: hour, viewModel: viewModel)
                                    .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                }
            }
        }
    }
}

struct HourlyForecastRow: View {
    let hour: HourlyForecast
    let viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.formatTime(hour.time))
                .font(.system(size: 22))
                .frame(width: 60, alignment: .leading)
                .padding()
                .foregroundColor(viewModel.textColor)
            
            Spacer()
            
            KFImage(URL(string: "https:\(hour.condition.icon)"))
                .resizable()
                .frame(width: 80, height: 80)
            
            Spacer()
            
            Text("\(Int(hour.temp_c))°")
                .font(.system(size: 22))
                .frame(width: 60, alignment: .trailing)
                .padding()
                .foregroundColor(viewModel.textColor)
        }
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.4))
        .cornerRadius(10)
    }
}

struct DetailsForecastView_Previews: PreviewProvider {
    static var previews: some View {
        let forecastDay = ForecastDay(
            date: "2024-05-16",
            day: Day(maxtemp_c: 20, mintemp_c: 10, condition: Condition(text: "Sunny", icon: "")),
            hour: [
                HourlyForecast(time: "2024-05-16 15:00", temp_c: 15, condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")),
                HourlyForecast(time: "2024-05-16 16:00", temp_c: 14, condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"))
            ]
        )
        let viewModel = WeatherViewModel()
        DetailsForecastView(day: forecastDay, viewModel: viewModel)
    }
}
