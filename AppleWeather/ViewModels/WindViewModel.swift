//
//  WindViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 18/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class WindViewModel: ObservableObject {

    @Published var windSpeedValue = ""
    @Published var windSpeedUnits = ""
    @Published var windDirectionInDegrees = 0

    func publish(_ locationModel: LocationModel) {
        if let day = locationModel.location.days.first {
            
            // The VCW wind direction indicates the direction from where the wind is blowing from
            // but we want to indicate where the wind is blowing to
            // so lets swap it around 180°
            let windDirectionInDegrees = day.winddir < 180 ? Int(day.winddir + 180) : Int(day.winddir - 180)
            
            // I do not know what "metric" unit they provide, but it looks like that if I divide this number by 3.5 then I will get "mph"
            let windSpeedValue = "\(Int(day.windspeed / 3.5))"
            let windSpeedUnits = "mps"
            
            if self.windDirectionInDegrees != windDirectionInDegrees {
                self.windDirectionInDegrees = windDirectionInDegrees
            }
            if self.windSpeedValue != windSpeedValue {
                self.windSpeedValue = windSpeedValue
            }
            if self.windSpeedUnits != windSpeedUnits {
                self.windSpeedUnits = windSpeedUnits
            }
        }
    }
}
