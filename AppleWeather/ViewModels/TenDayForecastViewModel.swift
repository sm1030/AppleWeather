//
//  TenDayForecastModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 12/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class TenDayForecastViewModel: ObservableObject {

    @Published var days: [DayForecastModel] = []
    @Published var debugString: String = ""

    func publish(_ locationModel: LocationModel) {
        debugString = "\(locationModel.location.longitude)"
        let tenDays = locationModel.location.days.prefix(10)
        let tenDaysMinTemp = tenDays.sorted { $0.tempmin < $1.tempmin }.first?.tempmin
        let tenDaysMaxTemp = tenDays.sorted { $0.tempmax > $1.tempmax }.first?.tempmax
        let days = locationModel.location.days.prefix(10).map({ day in
            DayForecastModel(day: day, tempGradientMin: tenDaysMinTemp ?? day.tempmin, tempGradientMax: tenDaysMaxTemp ?? day.tempmax)
        })
        if self.days.count != days.count || self.days.first != days.first || self.days.last != days.last {
            self.days = days
        }
    }
}

struct DayForecastModel: Identifiable, Equatable {
    let id = UUID()
    let dayOfWeek: String
    let icon: String
    let precipProb: String?
    let minTemp: String
    let maxTemp: String
    let tempGradient: [IdentifiableColor]
    
    init(day: VCW_Day, tempGradientMin: Float, tempGradientMax: Float) {
        dayOfWeek = day.datetime.vcwDateStringToDayOfWeek() ?? "---"
        icon = day.icon
        
        if day.icon == "clear-day" || day.icon == "clear-night" || day.icon == "partly-cloudy-day" || day.icon ==  "partly-cloudy-night" || day.icon == "cloudy" {
            precipProb = nil
        } else {
            precipProb = day.precipprob > 0 ? "\(Int(day.precipprob))%" : nil
        }
        
        minTemp = String(vcw_temperature: day.tempmin)
        maxTemp = String(vcw_temperature: day.tempmax)
        
        var gradient: [IdentifiableColor] = []
        for temp in Int(tempGradientMin)...Int(tempGradientMax) {
            if temp < Int(day.tempmin) || temp > Int(day.tempmax) {
                gradient.append(IdentifiableColor(color: Color(hex: "4A7EAB")))
            } else {
                gradient.append(IdentifiableColor(color: Color(temperature: Float(temp))))
            }
        }
        tempGradient = gradient
    }
    
    static func == (lhs: DayForecastModel, rhs: DayForecastModel) -> Bool {
        lhs.dayOfWeek == rhs.dayOfWeek &&
        lhs.icon == rhs.icon &&
        lhs.precipProb == rhs.precipProb &&
        lhs.minTemp == rhs.minTemp &&
        lhs.maxTemp == rhs.maxTemp
    }
}

struct IdentifiableColor: Identifiable {
    let id = UUID()
    let color: Color
}
