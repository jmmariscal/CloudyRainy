//
//  ForecastModel.swift
//  CloudyRainy
//
//  Created by Juan M Mariscal on 6/24/21.
//

import Foundation
import UIKit

struct Weather: Codable {
    var description: [Description]
    var temp: Float
}

struct Description: Codable {
    let description: String
}



