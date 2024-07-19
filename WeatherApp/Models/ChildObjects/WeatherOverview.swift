//
//  WeatherOverview.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation


struct WeatherOverview: Identifiable, Codable {
    var uniqueId = UUID()
    let id: Int
    let main: String
    
    /// Specified which fields should be considered while decoding JSON;
    /// 'uniqueId' has been added only to satisfy the list view requirements while rendering its rows
    private enum CodingKeys: String, CodingKey {
        case id, main
    }
}
