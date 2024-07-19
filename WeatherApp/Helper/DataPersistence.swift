//
//  DataPersistence.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/18/24.
//

import Foundation

/// Used for persisting last retrieved weather data in the local storage.
/// Implemented using UserDefaults (normally used for storing user preferences/settings) for simplicity.

class DataPersistence {
    
    static func persist<T: Codable>(data: Data, forType type: T.Type) {
        UserDefaults.standard.set(data, forKey: "\(T.self)")
    }
    
    static func retrieveLastSavedData<T: Codable>(dataType: T.Type) -> T? {
        var model: T?
        if let lastSavedData = UserDefaults.standard.data(forKey: "\(T.self)") {
            do {
                model = try JSONDecoder().decode(T.self, from: lastSavedData)
            } catch {
                print(error.localizedDescription)
            }
        }
        return model
    }
    
    static func clear() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func isFirstLaunch() -> Bool {
        let isFirstLaunch = !(UserDefaults.standard.bool(forKey: "user_onboarded"))
        if isFirstLaunch {
            UserDefaults.standard.setValue(true, forKey: "user_onboarded")
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
