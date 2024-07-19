//
//  HourlyForecastViewModel.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

class HourlyForecastViewModel: ObservableObject {
    
    /// When the below variable gets set, HourlyForecastView is asked to re-render itself to show the updated data
    @Published var forecastWeatherData: ForecastWeather?
    private let networkManager = NetworkManager()
    
    func fetchForecastWeatherData(from endpoint: APIEndpoint) {
        networkManager.call(endpoint: endpoint, modelType: ForecastWeather.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecastWeatherData):
                    self?.forecastWeatherData = forecastWeatherData
                case .failure(let error):
                    //Handle error returned by the network manager here
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Passing root-level data object type to retrieve an instance of recently saved weather data from the memory
    func retrieveLastSavedData() {
        self.forecastWeatherData = DataPersistence.retrieveLastSavedData(dataType: ForecastWeather.self)
    }
}
