//
//  Helper.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import Foundation

struct Helper {
    static func isMorning() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        print("Timeeee \(hour)")
        return hour >= Constants.TimeRange.morningStart && hour < Constants.TimeRange.eveningStart
    }
}
