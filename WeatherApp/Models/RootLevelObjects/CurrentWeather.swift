//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

/// Top-level object for current weather data
struct CurrentWeather: Codable {
    let weather: [WeatherOverview]
    let main: WeatherDetail
    let wind: Wind
    let name: String
}
