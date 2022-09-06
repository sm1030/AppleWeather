//
//  PressureViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 19/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class PressureViewModel: ObservableObject {

    @Published var pressureText: String = ""
    @Published var pressure: Int = 0
    @Published var maxPressure: Int = 0
    @Published var minPressure: Int = 0
    @Published var directionSymbol: String = "equal"

    func publish(_ locationModel: LocationModel) {
        if let day = locationModel.location.days.first {
            let pressure = Int(day.pressure)
            var maxPressure = Int(day.hours.sorted() { $0.pressure > $1.pressure }.first?.pressure ?? 0)
            var minPressure = Int(day.hours.sorted() { $0.pressure < $1.pressure }.first?.pressure ?? 0)
            
            let middle = Int((maxPressure + minPressure) / 2)
            
            var directionSymbol: String
            if pressure > middle {
                directionSymbol = "arrow.up"
                maxPressure = pressure
                minPressure = pressure - 10
            } else if pressure < middle {
                directionSymbol = "arrow.down"
                minPressure = pressure
                maxPressure = pressure + 10
            } else {
                directionSymbol = "equal"
                minPressure = pressure - 5
                maxPressure = pressure + 5
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSeparator = ","
            numberFormatter.groupingSize = 3
            let pressureText = numberFormatter.string(for: pressure) ?? ""
            
            if self.pressureText != pressureText {
                self.pressureText = pressureText
            }
            if self.pressure != pressure {
                self.pressure = pressure
            }
            if self.maxPressure != maxPressure {
                self.maxPressure = maxPressure
            }
            if self.minPressure != minPressure {
                self.minPressure = minPressure
            }
            if self.directionSymbol != directionSymbol {
                self.directionSymbol = directionSymbol
            }
        }
    }
}


