//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Omar on 16/05/2024.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkProtocol {
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        print("Fetching data from URL: \(urlString)")
        AF.request(urlString).validate().responseData { response in
            switch response.result {
            case .success(let data):
                print("Raw response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decodedData))
                } catch {
                    print("Decoding error: \(error)")
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                print("Request error: \(error)")
                if let data = response.data {
                    print("Raw error response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
                completionHandler(.failure(error))
            }
        }
    }
}
