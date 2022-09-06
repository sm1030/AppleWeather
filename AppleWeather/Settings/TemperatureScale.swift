//
//  TemperatureScales.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

enum TemperatureScales: String {
    case celsius
    case fahrenheit
}

extension UserDefaults {
    static var temperatureScale : TemperatureScales {
            set {
                let defaults = UserDefaults.standard
                defaults.set(newValue, forKey: "TemperatureScale")
            }

            get {
                let defaults = UserDefaults.standard
                let rawValue = defaults.string(forKey: "TemperatureScale") ?? ""
                return TemperatureScales(rawValue: rawValue) ?? .celsius
            }
        }
}
