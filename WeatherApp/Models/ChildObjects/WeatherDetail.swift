//
//  WeatherDetail.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

struct WeatherDetail: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
    
    /// Helper methods to prep-up data for proper rendering
    var getTemp: String {
        return String("\(Int(temp))°")
    }
    
    var getFeelTemp: String {
        return String("Feels like \(Int(feels_like))°")
    }
    
    var getHumidity: String {
        return String("\(humidity)%")
    }
}
