//
//  ForecastTableView.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import SwiftUI
import Kingfisher

struct ForecastTableView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let forecast: Forecast

    var body: some View {
        VStack {
            Text("3-DAY FORECAST")
                .font(.headline)
                .foregroundColor(viewModel.textColor)
                .padding()
            
            List {
                ForEach(forecast.forecastday, id: \.date) { day in
                    if let hourlyForecast = viewModel.hourlyForecastForCurrentTime(day: day) {
                        NavigationLink(destination: DetailsForecastView(day: day, viewModel: viewModel)) {
                            ForecastRow(day: day, hour: hourlyForecast, viewModel: viewModel)
                                .background(Color.clear)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .padding()
        }
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
    }
}

struct ForecastRow: View {
    let day: ForecastDay
    let hour: HourlyForecast
    let viewModel: WeatherViewModel

    var body: some View {
        HStack {
            Text(viewModel.formatDate(day.date))
                .foregroundColor(viewModel.textColor)
                .font(.system(size: 20))
                .frame(width: 60, alignment: .leading)
            
            Spacer()
            
            KFImage(URL(string: "https:\(hour.condition.icon)"))
                .resizable()
                .frame(width: 45, height: 45)
            
            Spacer()
            
            Text("\(String(format: "%.1f", day.day.mintemp_c))° - \(String(format: "%.1f", day.day.maxtemp_c))°")
                .foregroundColor(viewModel.textColor)
                .font(.system(size: 20))
                .frame(width: 150, alignment: .trailing)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.clear)
    }
}

struct ForecastTableView_Previews: PreviewProvider {
    static var previews: some View {
        let forecast = Forecast(forecastday: [
            ForecastDay(date: "2024-05-19", day: Day(maxtemp_c: 15.5, mintemp_c: 7.8, condition: Condition(text: "Partly Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")), hour: [HourlyForecast(time: "2024-05-16 15:00", temp_c: 15.5, condition: Condition(text: "Partly Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"))]),
            ForecastDay(date: "2024-05-20", day: Day(maxtemp_c: 16.1, mintemp_c: 6.4, condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")), hour: [HourlyForecast(time: "2024-05-17 15:00", temp_c: 16.1, condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"))]),
            ForecastDay(date: "2024-05-21", day: Day(maxtemp_c: 17.8, mintemp_c: 8.7, condition: Condition(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")), hour: [HourlyForecast(time: "2024-05-18 15:00", temp_c: 17.8, condition: Condition(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"))])
        ])
        let viewModel = WeatherViewModel()
        ForecastTableView(viewModel: viewModel, forecast: forecast)
    }
}
