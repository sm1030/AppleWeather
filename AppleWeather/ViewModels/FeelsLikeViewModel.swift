//
//  FeelsLikeViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 19/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class FeelsLikeViewModel: TwoLinesMessageViewModel {

    func publish(_ locationModel: LocationModel) {
        if let hourWeather = locationModel.currentHourWeather {
            
            let topMessage = String(vcw_temperature: hourWeather.feelslike)
            
            let bottomMessage: String
            if hourWeather.feelslike < hourWeather.temp {
                bottomMessage = "Wind is making it feel cooler."
            } else {
                bottomMessage = "Simular to the actual temperature"
            }
            
            if self.topMessage != topMessage {
                self.topMessage = topMessage
            }
            if self.bottomMessage != bottomMessage {
                self.bottomMessage = bottomMessage
            }
        }
    }
}


