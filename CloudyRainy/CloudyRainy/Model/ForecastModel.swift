//
//  ForecastModel.swift
//  CloudyRainy
//
//  Created by Juan M Mariscal on 6/24/21.
//

import Foundation
import UIKit

struct WeatherData: Decodable {
    let list: [List]
}

struct Weather: Codable {
    var description: String?
}

struct WeatherMain: Codable {
    var temp: Float?
}

struct List: Decodable {
    let main: WeatherMain
    let weather: [Weather]
}



