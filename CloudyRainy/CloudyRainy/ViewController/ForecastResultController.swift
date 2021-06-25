//
//  ForecastResultController.swift
//  CloudyRainy
//
//  Created by Juan M Mariscal on 6/24/21.
//

import Foundation
import UIKit

class ForecastResultController {
    
    enum NetworkError: Error {
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
    
    enum Endpoints {
        static let baseURL = "api.openweathermap.org/data/2.5/weather?q={city name}&appid=5e2fae3f2addb2a80f18f265838cd802"
    }
    
}

