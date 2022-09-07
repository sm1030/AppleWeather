//
//  MapViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 26/08/2022.
//

import SwiftUI
import Foundation
import MapKit

@MainActor final class MapViewModel: ObservableObject {

    @Published var locationName: String = ""
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
    @Published var temperature: Int = 0
    @Published var minTemperature: Int = 0
    @Published var maxTemperature: Int = 0
    @Published var tempGradientColors: [Color] = []
    
    weak var locationViewModel: LocationViewModel?

    func publish(_ locationModel: LocationModel) {
        let locationName = locationModel.location.address.capitalized.replacingOccurrences(of: "_", with: " ")
        let temperature = Int(locationModel.currentHourWeather?.temp ?? 0)
        let minTemperature = Int(locationModel.location.days.first?.tempmin ?? 0)
        let maxTemperature = Int(locationModel.location.days.first?.tempmax ?? 0)
        let center = CLLocationCoordinate2D(latitude: Double(locationModel.location.latitude),
                                            longitude: Double(locationModel.location.longitude))
        let mapRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        let tempGradientColors = (minTemperature...maxTemperature).map {
            Color(temperature: Float($0))
        }
        
        if self.locationName != locationName {
            self.locationName = locationName
        }
        if self.mapRegion.center.longitude != mapRegion.center.longitude {
            self.mapRegion = mapRegion
        }
        if self.temperature != temperature {
            self.temperature = temperature
        }
        if self.minTemperature != minTemperature || self.maxTemperature != maxTemperature {
            self.tempGradientColors = tempGradientColors
        }
        if self.minTemperature != minTemperature {
            self.minTemperature = minTemperature
        }
        if self.maxTemperature != maxTemperature {
            self.maxTemperature = maxTemperature
        }
    }
    
    func moveToLocationLocation() {
        if let locationModel = locationViewModel?.locationModel {
            publish(locationModel)
        }
    }
    
    func moveToUserLocation() {
        if let locationModel = locationViewModel?.weatherViewModel?.locationViewModels.first?.locationModel {
            publish(locationModel)
        }
    }
}

