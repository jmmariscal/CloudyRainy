//
//  ForecastResultController.swift
//  CloudyRainy
//
//  Created by Juan M Mariscal on 6/24/21.
//

import Foundation
import UIKit

protocol ForecastResultDelegate: AnyObject{
    func didGetData(results: Result<Forecast, NetworkError>)
}

enum NetworkError: Error {
    case unauthorized
    case noData
    case decodeFailed
    case otherError(Error)
}

class ForecastResultController {
    
    var weather: Forecast?
    
    weak var delegate: ForecastResultDelegate?
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case pull = "PULL"
        case delete = "DELETE"
    }
    
    func searchWeatherByCity(searchTerm: String) {
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?q=\(searchTerm)&appid=5e2fae3f2addb2a80f18f265838cd802"
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Request the data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
               response.statusCode == 401 {
                self.delegate?.didGetData(results: .failure(.unauthorized))
                return
            }
            
            guard error == nil else {
                self.delegate?.didGetData(results: .failure(.otherError(error!)))
                return
            }
        
            guard let data = data else {
                self.delegate?.didGetData(results: .failure(.noData))
                return
            }
            
            // Decode the data
            let decoder = JSONDecoder()
            do {
                let weather = try decoder.decode(Forecast.self, from: data)
                self.delegate?.didGetData(results: .success(weather))
            } catch {
                self.delegate?.didGetData(results: .failure(.decodeFailed))
                return
            }
        }.resume()
    }
    
}

