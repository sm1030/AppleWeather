//
//  VCW_StringHelpers.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

extension String {
    
    /// Convert VCW time string into total number if seconds in day
    /// - Returns: total number if seconds in day
    func vcwTimeStringToSeconds() -> Int? {
        let parts = self.split(separator: ":")
        guard parts.count == 3,
              let hours = Int(parts[0]),
              let minutes = Int(parts[1]),
              let seconds = Int(parts[2]) else {
            return nil
        }
        return hours * 3600 + minutes * 60 + seconds
    }
    
    /// Extract hour value from VCW time string
    /// - Returns: Hour value from VCW time string
    func vcwTimeStringToHours() -> Int? {
        let parts = self.split(separator: ":")
        guard parts.count == 3,
              let hours = Int(parts[0]) else {
            return nil
        }
        return hours
    }
    
    /// Extract hour value from VCW time string
    /// - Returns: Hour value from VCW time string
    func vcwTimeStringToHoursAndMinutesString() -> String? {
        let parts = self.split(separator: ":")
        guard parts.count == 3 else {
            return nil
        }
        return "\(Int(parts[0])!):\(parts[1])"
    }
    
    /// Turns "yyyy-MM-dd" string into day of week string
    /// - Returns: Day of week string or "Today" for current date
    func vcwDateStringToDayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self)!
        
        let todayString = dateFormatter.string(from: Date())
        if self == todayString {
            return "Today"
        } else {
            dateFormatter.dateFormat = "E"
            let resultString = dateFormatter.string(from: date)
            return resultString
        }
    }
    
    init(vcw_temperature: Float?, temperatureScale: TemperatureScales? = UserDefaults.temperatureScale) {
        if let temp = vcw_temperature {
            let roundedTemp = Int(round(temp))
            switch temperatureScale {
            case .celsius, nil:
                self = "\(roundedTemp)°"
            case .fahrenheit:
                self = "\((roundedTemp * 9 / 5) + 32)°"
            }
        } else {
            self = "--"
        }
    }
}
