//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

class CurrentWeatherViewModel: ObservableObject {
    
    /// When the below variable gets set, CurrentWeatherView is asked to re-render itself to show the updated data
    @Published var currentWeatherData: CurrentWeather?
    private let networkManager = NetworkManager()
    
    func fetchCurrentWeatherData(from endpoint: APIEndpoint) {
        networkManager.call(endpoint: endpoint, modelType: CurrentWeather.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let currentWeatherData):
                    self?.currentWeatherData = currentWeatherData
                case .failure(let error):
                    //Handle error returned by the network manager here
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Passing root-level data object type to retrieve an instance of recently saved weather data from the memory
    func retrieveLastSavedData() {
        self.currentWeatherData = DataPersistence.retrieveLastSavedData(dataType: CurrentWeather.self)
    }
}
