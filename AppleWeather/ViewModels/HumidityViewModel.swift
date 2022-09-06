//
//  HumidityViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 19/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class HumidityViewModel: TwoLinesMessageViewModel {

    func publish(_ locationModel: LocationModel) {
        if let hourWeather = locationModel.currentHourWeather {
            let topMessage = "\(Int(hourWeather.humidity))%"
            let dewpoint = 17.625 * hourWeather.temp / (hourWeather.temp + 243.04)
            let bottomMessage = "The dew point is \(String(vcw_temperature: dewpoint)) right now."
            
            if self.topMessage != topMessage {
                self.topMessage = topMessage
            }
            if self.bottomMessage != bottomMessage {
                self.bottomMessage = bottomMessage
            }
        }
    }
}


