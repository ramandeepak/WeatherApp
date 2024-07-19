//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/16/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    @State private var showingDetail = false
    
    var body: some Scene {
        WindowGroup {
            CurrentWeatherView()
                .onAppear {
                    if DataPersistence.isFirstLaunch() {
                        showingDetail = true
                    }
                }
                .fullScreenCover(isPresented: $showingDetail) {
                    WelcomeView()
                }
                .transaction({ transaction in
                    transaction.disablesAnimations = true
                })
        }
    }
}
