//
//  APIEndpoints.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

// Enpoint URL constant parameters
struct QueryParam {
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let appId = "33c4c09919a7587805a38c476bb592ec"
    static let units = "imperial"
    static let forecastCount = 10
}

// Returns the complete API endpoint URL for the given service
enum APIEndpoint {
    case current(city: String)
    case forecast(city: String)
    
    func buildURL() -> String? {
        
        var finalURL: String?
        
        switch self {
        case .current(let city):
            finalURL = "\(QueryParam.baseURL)/weather?q=\(city)&appid=\(QueryParam.appId)&units=\(QueryParam.units)"
        case .forecast(let city):
            finalURL = "\(QueryParam.baseURL)/forecast?q=\(city)&cnt=\(QueryParam.forecastCount)&appid=\(QueryParam.appId)&units=\(QueryParam.units)"
        }
        
        //Replace any spaces with percent encoding, in case user enters any city name with two words.
        finalURL = finalURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return finalURL
    }
}
