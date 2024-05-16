//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//
import Foundation
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var weather: WeatherResponse?
    @Published var isMorning: Bool = Helper.isMorning()
    private let networkService: NetworkProtocol
    private let locationManager = CLLocationManager()
    
    init(networkService: NetworkProtocol = NetworkService()) {
        self.networkService = networkService
        super.init()
        locationManager.delegate = self
    }
    
    func fetchWeather(for location: CLLocation) {
        let urlString = "\(Constants.baseUrl)?key=\(Constants.apiKey)&q=\(location.coordinate.latitude),\(location.coordinate.longitude)&days=3&aqi=yes&alerts=no"
        
        networkService.fetchData(urlString: urlString, decodingType: WeatherResponse.self) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self?.weather = weatherResponse
                }
            case .failure(let error):
                print("Error fetching weather: \(error.localizedDescription)")
            }
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchWeather(for: location)
        locationManager.stopUpdatingLocation() //comment lw h3oz el location dyman yt8er
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.isMorning = Helper.isMorning()
            }
        }
    }
    func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateObj = dateFormatter.date(from: date) else { return date }
        
        if Calendar.current.isDateInToday(dateObj) {
            return "Today"
        } else {
            dateFormatter.dateFormat = "EEE"
            return dateFormatter.string(from: dateObj)
        }
    }
    func hourlyForecastForCurrentTime(day: ForecastDay) -> HourlyForecast? {
        let currentHour = Calendar.current.component(.hour, from: Date())
        return day.hour.first { Calendar.current.component(.hour, from: DateFormatter().date(from: $0.time) ?? Date()) == currentHour }
    }
    func filteredHourlyForecast(day: ForecastDay) -> [HourlyForecast] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            if formatDate(day.date) == "Today" {
                let currentTime = Date()
                return day.hour.filter { dateFormatter.date(from: $0.time)! >= currentTime }
            } else {
                return day.hour
            }
        }
    func formatTime(_ time: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            guard let dateObj = dateFormatter.date(from: time) else { return time }
            
            dateFormatter.dateFormat = "h a"
            return dateFormatter.string(from: dateObj)
        }
}
