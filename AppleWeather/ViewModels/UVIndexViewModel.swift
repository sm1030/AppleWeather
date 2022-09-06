//
//  UVIndexViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 16/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class UVIndexViewModel: ObservableObject {

    @Published var uvIndex: String = ""
    @Published var uvLevel: String = ""
    @Published var scaleColors: [Color] = [Color(hex: "6ACD65"),
                                           Color(hex: "B7D24D"),
                                           Color(hex: "F7D54A"),
                                           Color(hex: "F3B741"),
                                           Color(hex: "F09C3B"),
                                           Color(hex: "ED6C48"),
                                           Color(hex: "E24C76"),
                                           Color(hex: "B45FE6")]
    @Published var scaleValue: Float = 0
    @Published var message: String = ""

    func publish(_ locationModel: LocationModel) {
        if let day = locationModel.location.days.first {
            var uvIndex = "\(Int(day.uvindex))"
            var uvLevel: String
            if day.uvindex < 3 {
                uvLevel = "Low"
            } else if day.uvindex < 6 {
                uvLevel = "Medium"
            } else if day.uvindex < 8 {
                uvLevel = "High"
            } else if day.uvindex < 11 {
                uvLevel = "Very High"
            } else {
                uvLevel = "Extreme"
            }
            
            var scaleValue = day.uvindex / 10
            
            var fromHour: Int?
            var toHour: Int = 0
            for hour in day.hours {
                if hour.uvindex > 1 {
                    if fromHour == nil {
                        fromHour = hour.datetime.vcwTimeStringToHours()!
                    }
                    toHour = hour.datetime.vcwTimeStringToHours()!
                }
            }
            var message: String = ""
            if let fromHour = fromHour {
                let currentHour = Int((locationModel.localTimeInSeconds ?? 0) / 3600)
                if currentHour > toHour {
                    message = "Low for the rest of the day"
                    scaleValue = 0
                    uvIndex = "0"
                    uvLevel = "Low"
                } else if currentHour > fromHour {
                    message = "Use sun protection until \(toHour):00"
                } else {
                    message = "Use sun protection \(fromHour):00-\(toHour):00"
                }
            } else {
                message = "Low levels all day"
            }
            
            if self.uvIndex != uvIndex {
                self.uvIndex = uvIndex
            }
            if self.uvLevel != uvLevel {
                self.uvLevel = uvLevel
            }
            if self.scaleValue != scaleValue {
                self.scaleValue = scaleValue
            }
            if self.message != message {
                self.message = message
            }
        }
    }
}
