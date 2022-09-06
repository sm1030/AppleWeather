//
//  VisibilityViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 19/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class VisibilityViewModel: TwoLinesMessageViewModel {

    func publish(_ locationModel: LocationModel) {
        if let hourWeather = locationModel.currentHourWeather {
            let topMessage = "\(Int(hourWeather.visibility)) km"
            
            var bottomMessage: String
            if hourWeather.visibility > 10 {
                bottomMessage = "It's perfectly clear right now"
            } else if hourWeather.visibility > 4 {
                bottomMessage = "It's clear now"
            } else if hourWeather.visibility > 1 {
                bottomMessage = "Bad visibility"
            } else {
                bottomMessage = "Very bad visibility"
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


