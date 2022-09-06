//
//  Locations.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

extension UserDefaults {
    static var locations : [String] {
            set {
                let defaults = UserDefaults.standard
                defaults.set(newValue, forKey: "Locations")
            }

            get {
                let defaults = UserDefaults.standard
                return (defaults.array(forKey: "Locations") as? [String]) ?? ["london", "new_york", "sydney", "tokyo"]
            }
        }
}
