//
//  Wind.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

struct Wind: Codable {
    let speed: Double
    
    /// Helper method to prep-up data for proper rendering
    var getSpeed: String {
        return String("\(speed) m/h")
    }
}
