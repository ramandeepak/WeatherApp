//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/16/24.
//

import SwiftUI

struct CurrentWeatherView: View {
   
    @StateObject private var vm = CurrentWeatherViewModel()
    /// Binding var for text typed in the textfield
    @State private var city: String = ""
    /// Ensures a network call is triggered only when there is a change in the text entered in the textfield;
    /// no network call happens if the user simply sets the focus on the textfield and taps 'return' to dimiss the keyboard,
    /// without actually typing/changing anything.
    @State private var hasCityChanged = false
    /// Binding var for navigation destination; here destination being HourlyForecastView
    @State private var showHourlyForecastView = false

    var body: some View {
        /// GeometryReader is used to make sure the whole screen is not moved up when the keyboard shows up.
        NavigationStack {
            GeometryReader { _ in
                VStack(alignment: .leading, spacing: 50) {
                    TextField("Enter a city...", text: $city)
                        .onChange(of: city) { _ in
                            hasCityChanged = true
                        }
                        .onSubmit {
                            if hasCityChanged && city.count > 0 {
                                /// If city has changed, clear persisted data
                                /// set bool flag to false
                                /// fetch new data from the API for the new city entered by the user
                                DataPersistence.clear()
                                hasCityChanged = false
                                vm.fetchCurrentWeatherData(from: APIEndpoint.current(city: city))
                            }
                        }
                        .frame(height: 45)
                        .padding(EdgeInsets(top: 0,
                                            leading: 15,
                                            bottom: 0,
                                            trailing: 0))
                        .textFieldStyle(.plain)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white))
                        .background(in: RoundedRectangle(cornerRadius: 20))
                        .padding(.trailing, 25)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: -10) {
                            Text(vm.currentWeatherData?.main.getTemp ?? "--")
                                .bold()
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            HStack(spacing: 25) {
                                Text(vm.currentWeatherData?.weather[0].main ?? "--")
                                    .bold()
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                Image(systemName: WeatherIconMapper.icon(for: vm.currentWeatherData?.weather[0].id ?? -1).rawValue)
                                    .font(.system(size: 60))
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, .yellow)
                            }
                        }
                    
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 2) {
                                Text(vm.currentWeatherData?.name ?? "--")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                Image(systemName: "mappin")
                                    .font(.system(size: 18))
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white)
                            }
                            Text(vm.currentWeatherData?.main.getFeelTemp ?? "--")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading)
                    HStack {
                        VStack {
                            Image(systemName: "humidity.fill")
                                .font(.system(size: 45))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white)
                            Text("Humidity")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text(vm.currentWeatherData?.main.getHumidity ?? "--")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: 100, maxHeight: 100)
                        .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                        .background(LinearGradient(colors: [Color("light"),
                                                            Color("dark")],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing))
                        .cornerRadius(16)
                        Spacer()
                        VStack {
                            Image(systemName: "wind")
                                .font(.system(size: 45))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white)
                            Text("Wind")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text(vm.currentWeatherData?.wind.getSpeed ?? "--")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: 100,
                               maxHeight: 100)
                        .padding(EdgeInsets(top: 15,
                                            leading: 20,
                                            bottom: 15,
                                            trailing: 20))
                        .background(LinearGradient(colors: [Color("light"),
                                                            Color("dark")],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing))
                        .cornerRadius(16)
                    }
                    .padding(.trailing, 50)
                    .padding(.leading, 25)
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showHourlyForecastView = true
                        }, label: {
                            Text("Weekly Forecast ")
                                .foregroundColor(.white)
                                .font(.title3)
                            
                                +
                            Text(Image(systemName: "arrowshape.forward.fill"))
                                .font(.title3)
                                .foregroundColor(.white)
                        })
                        .buttonStyle(PurpleButton())
                        Spacer()
                    }
                    .padding(.leading, -25)
                    .padding(.bottom, 50)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $showHourlyForecastView) {
                    HourlyForecastView(city: city)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 30)
                .padding(.leading, 25)
                .background(LinearGradient(colors: [Color("light"),
                                                    Color("dark")],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
            }
        }
        .onAppear {
            /// When this screen is about to appear check if viewmodel can provide data;
            /// if not retrieve previously persisted data;
            /// if no persisted data available, show placeholders (--) for values, until user enters a city.
            if vm.currentWeatherData == nil {
                vm.retrieveLastSavedData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
