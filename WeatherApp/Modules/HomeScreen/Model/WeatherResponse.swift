//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//
import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: Condition
    let feelslike_c: Double
    let humidity: Int
    let pressure_mb: Double
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable ,Identifiable{
    let id = UUID()
    let date: String
    let day: Day
    let hour: [HourlyForecast]  
}

struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: Condition
}

struct HourlyForecast: Codable,Identifiable {
    let id = UUID()
    var time: String
    let temp_c: Double
    let condition: Condition
}
