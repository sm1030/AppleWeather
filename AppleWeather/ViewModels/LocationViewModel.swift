//
//  LocationModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

@MainActor final class LocationViewModel: ObservableObject, Identifiable {
    
    @Published var name: String = ""
    @Published var temperature: String = "--"
    @Published var temperatureLow: String = ""
    @Published var temperatureHigh: String = ""
    @Published var conditions: String = ""
    @Published var isDataLoaded: Bool = false
    @Published var resolvedAddress: String = ""
    
    @Published var tenDayForecastViewModel: TenDayForecastViewModel
    @Published var hourlyForecastViewModel: HourlyForecastViewModel
    @Published var uvIndexViewModel: UVIndexViewModel
    @Published var sunsetViewModel: SunsetViewModel
    @Published var windViewModel: WindViewModel
    @Published var rainfallViewModel: RainfallViewModel
    @Published var feelsLikeViewModel: FeelsLikeViewModel
    @Published var humidityViewModel: HumidityViewModel
    @Published var visibilityViewModel: VisibilityViewModel
    @Published var pressureViewModel: PressureViewModel
    @Published var airPollutionViewModel: AirPollutionViewModel
    @Published var temperatureViewModel: TemperatureViewModel
    @Published var mapViewModel: MapViewModel
    
    let locationModel: LocationModel
    
    weak var weatherViewModel: WeatherViewModel?
    
    init(address: String, mockedData: Data? = nil, asyncMode: Bool = true) {
        self.locationModel = LocationModel(address: address, mockedData: mockedData, asyncMode: asyncMode)
        self.tenDayForecastViewModel = TenDayForecastViewModel()
        self.hourlyForecastViewModel = HourlyForecastViewModel()
        self.uvIndexViewModel = UVIndexViewModel()
        self.sunsetViewModel = SunsetViewModel()
        self.windViewModel = WindViewModel()
        self.rainfallViewModel = RainfallViewModel()
        self.feelsLikeViewModel = FeelsLikeViewModel()
        self.humidityViewModel = HumidityViewModel()
        self.visibilityViewModel = VisibilityViewModel()
        self.pressureViewModel = PressureViewModel()
        self.airPollutionViewModel = AirPollutionViewModel()
        self.temperatureViewModel = TemperatureViewModel()
        self.mapViewModel = MapViewModel()
        temperatureViewModel.locationViewModel = self
        mapViewModel.locationViewModel = self
        name = locationModel.location.address.capitalized.replacingOccurrences(of: "_", with: " ")
    }
    
    public func fetchLatestWeatherInformation(completion: @escaping ((Result<VCW_Location, Error>) -> ())) {
        let lastAcceptedUpdateTime = Calendar.current.date( byAdding: .hour, value: -1, to: Date())!
        if locationModel.lastUpdateTime < lastAcceptedUpdateTime {
            locationModel.update { [weak self] result in
                guard let self = self else { return }
                self.publishLocationModelChanges()
                self.notifyChildViewModels()
                completion(result)
            }
        }
    }
    
    private func notifyChildViewModels() {
        tenDayForecastViewModel.publish(locationModel)
        hourlyForecastViewModel.publish(locationModel)
        uvIndexViewModel.publish(locationModel)
        sunsetViewModel.publish(locationModel)
        windViewModel.publish(locationModel)
        rainfallViewModel.publish(locationModel)
        feelsLikeViewModel.publish(locationModel)
        humidityViewModel.publish(locationModel)
        visibilityViewModel.publish(locationModel)
        pressureViewModel.publish(locationModel)
        airPollutionViewModel.publish(locationModel)
        temperatureViewModel.publish(locationModel)
        mapViewModel.publish(locationModel)
    }
    
    private func publishLocationModelChanges() {
        switch locationModel.updateResult {
        case .failure(let error):
            if self.weatherViewModel?.isShowingAlert == false {
                if let vcwError = error as? VCW_Error, case .nonJsonResponse(let string) = vcwError {
                    if string.starts(with: "You have exceeded the maximum number of daily result records") {
                        self.weatherViewModel?.alertMessage = "This Visual Crossing Weather API account have exceeded the maximum number of daily requests. You can get your own free Visual Crossing Weather token from www.visualcrossing.com or you can use offline mock data"
                    } else {
                        self.weatherViewModel?.alertMessage = string
                    }
                } else {
                    self.weatherViewModel?.alertMessage = error.localizedDescription
                }
                self.weatherViewModel?.isShowingAlert.toggle()
            }
        case .none:
            return
        case .success:
            let name: String
            if let resolvedAddress = locationModel.location.resolvedAddress.split(separator: ",").first {
                name = String(resolvedAddress)
            } else {
                name = locationModel.location.address.replacingOccurrences(of: "_", with: " ").capitalized
            }
            
            let temperature = String(vcw_temperature: locationModel.currentHourWeather?.temp)
            let temperatureLow = String(vcw_temperature: locationModel.location.days.first?.tempmin)
            let temperatureHigh = String(vcw_temperature: locationModel.location.days.first?.tempmax)
            let conditions = locationModel.currentHourWeather?.conditions.capitalized ?? "---"
            let resolvedAddress = locationModel.location.resolvedAddress
            let isDataLoaded = true
            
            if self.name != name {
                self.name = name
            }
            if self.temperature != temperature {
                self.temperature = temperature
            }
            if self.temperatureLow != temperatureLow {
                self.temperatureLow = temperatureLow
            }
            if self.temperatureHigh != temperatureHigh {
                self.temperatureHigh = temperatureHigh
            }
            if self.conditions != conditions {
                self.conditions = conditions
            }
            if self.resolvedAddress != resolvedAddress {
                self.resolvedAddress = resolvedAddress
            }
            if self.isDataLoaded != isDataLoaded {
                self.isDataLoaded = isDataLoaded
            }
            
            if weatherViewModel?.selectedLocationViewModel.locationModel.location.address == self.locationModel.location.address  {
                weatherViewModel?.weatherBackgroundViewModel.publish(locationViewModel: self)
            }
        }
    }
}
