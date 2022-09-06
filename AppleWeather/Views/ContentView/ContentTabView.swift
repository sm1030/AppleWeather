//
//  ContentTabView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 07/08/2022.
//

import SwiftUI

struct ContentTabView: View {
    @EnvironmentObject var weatherModel: WeatherViewModel

    var body: some View {
        TabView(selection: $weatherModel.selectedTabId) {
            ForEach((0...weatherModel.locationViewModels.count-1), id: \.self) { id in
                let locationViewModel = weatherModel.locationViewModels[id]
                LocationView()
                    .environmentObject(locationViewModel)
                    .tag(id)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onChange(of: weatherModel.selectedTabId) { id in
            weatherModel.selectedLocationViewModel = weatherModel.locationViewModels[id]
        }
    }
}

struct ContentTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentTabView()
            .environmentObject(WeatherViewModel())
    }
}
