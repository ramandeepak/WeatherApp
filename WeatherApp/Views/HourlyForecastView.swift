//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/17/24.
//

import SwiftUI

struct HourlyForecastView: View {
    
    @StateObject private var vm = HourlyForecastViewModel()
    /// city var takes its input from the previous view; passed along while navigating here.
    var city: String?
    
    var body: some View {
            List(vm.forecastWeatherData?.list ?? []) { hourlyData in
                HStack {
                    HStack {
                        Image(systemName: WeatherIconMapper.icon(for: hourlyData.weather[0].id).rawValue)
                            .font(.system(size: 30))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .yellow)
                        Text(hourlyData.weather[0].main)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    Spacer()
                    HStack {
                        Text(hourlyData.main.getTemp)
                        Text("|")
                        Text(hourlyData.main.getFeelTemp)
                    }
                    .foregroundColor(.white)
                }
                .frame(height: 50)
                .listRowBackground(Color.clear)
                .listRowSeparatorTint(.white)
                .alignmentGuide(.listRowSeparatorLeading) { d in
                    d[.leading]
                }
            }
            .onAppear {
                /// Try to retrieve last saved data
                /// If VM still can't provide data, consider fetching from the API
                vm.retrieveLastSavedData()
                if vm.forecastWeatherData == nil,
                   let city = city,
                   city.count > 0 {
                    vm.fetchForecastWeatherData(from: .forecast(city: city))
                }
            }
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
            .background(LinearGradient(colors: [Color("light"),
                                                Color("dark")],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
    }
}

struct WeeklyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView()
    }
}
