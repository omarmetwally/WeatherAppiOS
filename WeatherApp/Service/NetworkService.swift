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
        AF.request(urlString).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
