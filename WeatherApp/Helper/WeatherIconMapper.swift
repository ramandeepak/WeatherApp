//
//  WeatherIconMapper.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

/// Open Weather API returns an id in reponse which identifies the type.
/// For example a id returned within the range of 500 and 531
/// could mean light or heavy rain; an id within the range of 801-804 could mean few clouds or overcast clouds.
/// Once the range is identified, the mapper returns the appropriate image (SF Font Image) for the weather type.
/// More info here: https://openweathermap.org/weather-conditions

enum WeatherIconMapper: String {
    
    case thunderstorm = "cloud.bolt.rain.fill"
    case drizzle = "cloud.drizzle.fill"
    case rain = "cloud.rain.fill"
    case snow = "cloud.snow.fill"
    case clear = "sun.max.fill"
    case clouds = "cloud.sun.fill"
    
    static func icon(for id: Int) -> WeatherIconMapper {
        let icon: WeatherIconMapper
        switch id {
        case 200...232:
            icon = .thunderstorm
        case 300...321:
            icon = .drizzle
        case 500...531:
            icon = .rain
        case 600...622:
            icon = .snow
        case 800:
            icon = .clear
        case 801...804:
            icon = .clouds
        default:
            icon = .clouds
        }
        return icon
    }
}
