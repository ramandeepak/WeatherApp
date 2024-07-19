//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/17/24.
//

import Foundation


/// Network manager makes use of the default session configuration; default time-out settings are used.
/// Inline comment shows how error handling can be implemeted for various scenarios; except for timeout which is returned
/// to the caller; Caller (viewmodel)  doesn't do much but simply prints the error message to the console.
class NetworkManager {
    
    func call<T: Codable>(endpoint: APIEndpoint,
                          modelType: T.Type,
                          completionHandler: @escaping (Result<T?, Error>) -> Void) {
    
        guard let url = URL(string: endpoint.buildURL() ?? "") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError, error.code == .timedOut {
                // Timeout error can be handled here for auto-retry, instead of returning it to the caller
                completionHandler(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                //An enum of custom error type can be created and returned to gracefully handle any 500s or 400s
                //completionHandler(.failure(nil))
                return
            }
            
            guard let data = data else {
                // Custom error type can be used here to handle the no data scenario
                //completionHandler(.failure(nil))
                return
            }
            
            // Data received is immediately persisted in the memory.
            //UserDefaults.standard.set(data, forKey: "\(T.self)")
            DataPersistence.persist(data: data, forType: T.self)
            // Decoding JSON...
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                // Returning any error encountered during JSON decoding; again, this scenario can also be brought under an enum
                // of custom error types
                completionHandler(.failure(error))
            }
            
        }
        .resume()
    }
}
