//
//  ForecastResultController.swift
//  CloudyRainy
//
//  Created by Juan M Mariscal on 6/24/21.
//

import Foundation
import UIKit

class ForecastResultController {
    
    var weather: Forecast?
    
    enum NetworkError: Error {
        case unauthorized
        case noData
        case decodeFailed
        case otherError(Error)
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case pull = "PULL"
        case delete = "DELETE"
    }
    
    func searchWeatherByCity(searchTerm: String, completion: @escaping (Result<Forecast, NetworkError>) -> Void) {
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?q=\(searchTerm)&appid=5e2fae3f2addb2a80f18f265838cd802"
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Request the data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
               response.statusCode == 401 {
                completion(.failure(.unauthorized))
                return
            }
            
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
        
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Decode the data
            let decoder = JSONDecoder()
            do {
                let weather = try decoder.decode(Forecast.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(.decodeFailed))
                return
            }
        }.resume()
    }
    
}

