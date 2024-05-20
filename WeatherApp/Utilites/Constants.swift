//
//  Constants.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import Foundation

struct Constants {
    static let apiKey = "9c37d92e9d3d4dc8a0c124203241605"
    static let baseUrl = "https://api.weatherapi.com/v1/forecast.json"
    
    enum TimeRange {
        static let morningStart = 5
        static let eveningStart = 18
    }
}
