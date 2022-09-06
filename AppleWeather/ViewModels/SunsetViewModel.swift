//
//  SunsetViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 16/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class SunsetViewModel: ObservableObject {

    @Published var sunriseInSeconds = 0
    @Published var sunsetInSeconds = 0
    @Published var sunPositionInSeconds = 0
    @Published var titleText: String = ""
    @Published var titleSFSymbol: String = ""
    @Published var topText: String = ""
    @Published var bottomText: String = ""

    func publish(_ locationModel: LocationModel) {
        if let day = locationModel.location.days.first {
            let titleText: String
            let titleSFSymbol: String
            let topText: String
            let bottomText: String
            
            let sunriseInSeconds = day.sunrise.vcwTimeStringToSeconds() ?? 0
            let sunsetInSeconds = day.sunset.vcwTimeStringToSeconds() ?? 0
            let sunPositionInSeconds = locationModel.localTimeInSeconds ?? 0
            if sunPositionInSeconds < sunriseInSeconds {
                titleText = "SUNRISE"
                titleSFSymbol = "sunrise"
                topText = day.sunrise.vcwTimeStringToHoursAndMinutesString() ?? "--:--"
                bottomText = "Sunset: \(day.sunset.vcwTimeStringToHoursAndMinutesString() ?? "--:--")"
            } else {
                titleText = "SUNSET"
                titleSFSymbol = "sunset"
                topText = day.sunset.vcwTimeStringToHoursAndMinutesString() ?? "--:--"
                bottomText = "Sunrise: \(day.sunrise.vcwTimeStringToHoursAndMinutesString() ?? "--:--")"
            }
            
            if self.sunriseInSeconds != sunriseInSeconds {
                self.sunriseInSeconds = sunriseInSeconds
            }
            if self.sunsetInSeconds != sunsetInSeconds {
                self.sunsetInSeconds = sunsetInSeconds
            }
            if self.sunPositionInSeconds != sunPositionInSeconds {
                self.sunPositionInSeconds = sunPositionInSeconds
            }
            if self.titleText != titleText {
                self.titleText = titleText
            }
            if self.titleSFSymbol != titleSFSymbol {
                self.titleSFSymbol = titleSFSymbol
            }
            if self.topText != topText {
                self.topText = topText
            }
            if self.bottomText != bottomText {
                self.bottomText = bottomText
            }
        }
    }
}

