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
}
