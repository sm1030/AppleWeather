//
//  ContentView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 07/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel(isUsingMockData: true)
    
    var body: some View {
        ZStack {
            WeatherBackgroundView()
                .environmentObject(weatherViewModel.weatherBackgroundViewModel)
            
            ContentTabBackgroundView(isNight: false)
            
            ContentTabView()
                .environmentObject(weatherViewModel)
            
            ContentBottomButtons()
                .environmentObject(weatherViewModel)
        }
        .alert(weatherViewModel.alertMessage, isPresented: $weatherViewModel.isShowingAlert) {
            Button("Use offline mock data") {
                weatherViewModel.switchLocationsToUseMockData()
            }
            Button("OK", role: .cancel) { }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
