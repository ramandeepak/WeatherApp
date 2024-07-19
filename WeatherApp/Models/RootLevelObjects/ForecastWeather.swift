//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

/// Top-level object for hourly forecast weather data
struct ForecastWeather: Codable {
    let list: [HourlyForecast]
}
