//
//  WeatherModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation
import SwiftUI

/// Main ContentView data model
@MainActor final class WeatherViewModel: ObservableObject {
    
    /// Content view TabView will present those location models as its pages
    @Published var locationViewModels: [LocationViewModel] = []
    @Published var weatherBackgroundViewModel = WeatherBackgroundViewModel()
    @Published var cityListViewModel = CityListViewModel()
    @Published var selectedTabId = 0
    
    /// When you scroll TabView and select new page then this location model will be set to selected one
    @Published var selectedLocationViewModel: LocationViewModel = LocationViewModel(address: "") {
        didSet {
            weatherBackgroundViewModel.publish(locationViewModel: selectedLocationViewModel)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.selectedLocationViewModel.fetchLatestWeatherInformation() { _ in }
            }
        }
    }
    
    @Published var isShowingAlert = false
    @Published var alertMessage = ""
    
    init(isUsingMockData: Bool = false, asyncMode: Bool = true) {
        let savedLocations = UserDefaults.locations
        locationViewModels = savedLocations.map { address in
            var mockedData: Data?
            if isUsingMockData {
                if let data = NSDataAsset(name: address)?.data {
                    mockedData = data
                }
            }
            let locationViewModel = LocationViewModel(address: address, mockedData: mockedData, asyncMode: asyncMode)
            locationViewModel.weatherViewModel = self
            if address == savedLocations.first {
                selectedLocationViewModel = locationViewModel
            }
            locationViewModel.fetchLatestWeatherInformation() { _ in }
            return locationViewModel
        }
        cityListViewModel.weatherViewModel = self
    }
    
    func saveCurrentCityList() {
        UserDefaults.locations = locationViewModels.map { $0.locationModel.location.address }
        UserDefaults.standard.synchronize()
    }
    
    func switchLocationsToUseMockData() {
        for locationViewModel in locationViewModels {
            let address = locationViewModel.locationModel.location.address
            locationViewModel.locationModel.mockedData = NSDataAsset(name: address)?.data
            locationViewModel.fetchLatestWeatherInformation() { _ in }
        }
    }
    
    func selectTabWithLocation(_ locationViewModel: LocationViewModel) {
        for id in (0...locationViewModels.count-1) {
            let location = locationViewModels[id]
            if location.locationModel.location.address == locationViewModel.locationModel.location.address {
                selectedLocationViewModel = locationViewModel
                selectedTabId = id
                return
            }
        }
    }
}
