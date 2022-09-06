//
//  HourlyForecastViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 15/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class HourlyForecastViewModel: ObservableObject {

    @Published var description: String = ""
    @Published var hours: [HourForecastModel] = []
    
    private let mockLocalTimeInSeconds: Int?
    
    init(mockLocalTimeInSeconds: Int? = nil) {
        self.mockLocalTimeInSeconds = mockLocalTimeInSeconds
    }

    func publish(_ locationModel: LocationModel) {
        let description = locationModel.location.description
        var hours: [HourForecastModel] = []
        if let vcwDay = locationModel.location.days.first, let localTimeInSeconds = mockLocalTimeInSeconds ?? locationModel.localTimeInSeconds {
            let sunriseHour = vcwDay.sunrise.vcwTimeStringToHours()
            let sunriseHoursAndMinutes = vcwDay.sunrise.vcwTimeStringToHoursAndMinutesString()
            let sunsetHour = vcwDay.sunset.vcwTimeStringToHours()
            let sunsetHoursAndMinutes = vcwDay.sunset.vcwTimeStringToHoursAndMinutesString()
            let currentHour = Int(localTimeInSeconds / 3600)
            
            let todayHours = locationModel.location.days[0].hours.suffix(24 - currentHour)
            let tomorrowHours = locationModel.location.days[1].hours.prefix(24 - todayHours.count)
            let twoDaysHours = todayHours + tomorrowHours
            
            
            for vcwHour in twoDaysHours {
                let hour = vcwHour.datetime.vcwTimeStringToHours()!
                let precipProb: String?
                if vcwHour.icon == "clear-day" || vcwHour.icon == "clear-night" || vcwHour.icon == "partly-cloudy-day" || vcwHour.icon ==  "partly-cloudy-night" || vcwHour.icon == "cloudy" {
                    precipProb = nil
                } else {
                    precipProb = vcwHour.precipprob > 0 ? "\(Int(vcwHour.precipprob))%" : nil
                }
                
                hours.append(HourForecastModel(id: vcwHour.datetimeEpoch,
                                               hour: hour == currentHour ? "Now" : "\(hour)",
                                               icon: vcwHour.icon,
                                               precipProb: precipProb,
                                               temp: String(vcw_temperature:vcwHour.temp)))
                
                if hour == sunriseHour {
                    hours.append(HourForecastModel(id: vcwDay.sunriseEpoch,
                                                   hour: sunriseHoursAndMinutes ?? "\(hour)",
                                                   icon: "sunrise",
                                                   precipProb: nil,
                                                   temp: "Sunrise"))
                }
                
                if hour == sunsetHour {
                    hours.append(HourForecastModel(id: vcwDay.sunsetEpoch,
                                                   hour: sunsetHoursAndMinutes ?? "\(hour)",
                                                   icon: "sunset",
                                                   precipProb: nil,
                                                   temp: "Sunset"))
                }
            }
        }
        if self.description != description {
            self.description = description
        }
        if self.hours.count != hours.count || self.hours.first != hours.first || self.hours.last != hours.last {
            self.hours = hours
        }
    }
}

struct HourForecastModel: Identifiable, Equatable {
    let id: Int
    let hour: String
    let icon: String
    let precipProb: String?
    let temp: String
}
