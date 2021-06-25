//
//  ForecastModel.swift
//  CloudyRainy
//
//  Created by Juan M Mariscal on 6/24/21.
//

import Foundation
import UIKit

struct Forecast: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}
struct Weather: Codable {
    let description: String
}
struct Main: Codable {
    let temp: Double
}




