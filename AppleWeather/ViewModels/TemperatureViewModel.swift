//
//  TemperatureViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 22/08/2022.
//

import SwiftUI
import Foundation
import MapKit

@MainActor final class TemperatureViewModel: ObservableObject {

    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
    @Published var temperature: Int = 0
    
    weak var locationViewModel: LocationViewModel?

    func publish(_ locationModel: LocationModel) {
        let temperature = Int(locationModel.currentHourWeather?.temp ?? 0)
        let center = CLLocationCoordinate2D(latitude: Double(locationModel.location.latitude), longitude: Double(locationModel.location.longitude))
        let mapRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        
        if self.temperature != temperature {
            self.temperature = temperature
        }
        if self.mapRegion.center.latitude != mapRegion.center.latitude && self.mapRegion.center.longitude != mapRegion.center.longitude {
            self.mapRegion = mapRegion
        }
    }
}
