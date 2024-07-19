//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

struct HourlyForecast: Identifiable, Codable {
    var id = UUID()
    let weather: [WeatherOverview]
    let main: WeatherDetail
    
    /// Specified which fields should be considered while decoding JSON;
    /// 'id' has been added only to satisfy the list view requirements while rendering its rows
    private enum CodingKeys: String, CodingKey {
        case weather, main
    }
}
