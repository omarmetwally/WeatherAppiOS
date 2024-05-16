//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//
import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    
    private let networkService: NetworkProtocol
    private let locationManager = LocationManager()
    
    init(networkService: NetworkProtocol = NetworkService()) {
        self.networkService = networkService
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
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
                DispatchQueue.main.async {
                    self?.errorMessage = "Error fetching weather: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestLocationPermission()
    }
}

extension WeatherViewModel: LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        fetchWeather(for: location)
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "Failed to get user's location: \(error.localizedDescription)"
        }
    }
}
