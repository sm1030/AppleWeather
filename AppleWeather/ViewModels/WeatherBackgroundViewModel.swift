//
//  WeatherBackgroundViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 28/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class WeatherBackgroundViewModel: ObservableObject {

    @Published var night: Bool = false
    @Published var sun: Bool = false
    @Published var rain: Bool = false
    @Published var clouds: CloudMode = .clear
    
    enum CloudMode {
        case clear
        case few
        case overcast
    }

    func publish(locationViewModel: LocationViewModel) {
        let locationModel = locationViewModel.locationModel
        if let hourWeather = locationModel.currentHourWeather {
            let night = locationModel.isNight
            let sun: Bool
            let rain: Bool
            let clouds: CloudMode
        
            switch hourWeather.icon {
            case "snow": // Amount of snow is greater than zero
                sun = false
                rain = true
                clouds = .overcast
            case "snow-showers-day": // Periods of snow during the day
                sun = false
                rain = true
                clouds = .overcast
            case "snow-showers-night": // Periods of snow during the night
                sun = false
                rain = true
                clouds = .overcast
            case "thunder-rain": // Thunderstorms throughout the day or night
                sun = false
                rain = true
                clouds = .overcast
            case "thunder-showers-day": // Possible thunderstorms throughout the day
                sun = false
                rain = true
                clouds = .overcast
            case "thunder-showers-night": // Possible thunderstorms throughout the night
                sun = false
                rain = true
                clouds = .overcast
            case "rain": // Amount of rainfall is greater than zero
                sun = false
                rain = true
                clouds = .overcast
            case "showers-day": // Rain showers during the day
                sun = false
                rain = true
                clouds = .overcast
            case "showers-night": // Rain showers during the night
                sun = false
                rain = true
                clouds = .overcast
            case "fog": // Visibility is low (lower than one kilometer or mile)
                sun = false
                rain = false
                clouds = .overcast
            case "wind": // Wind speed is high (greater than 30 kph or mph)
                sun = night ? false : true
                rain = false
                clouds = .clear
            case "cloudy": // Cloud cover is greater than 90% cover
                sun = false
                rain = false
                clouds = .overcast
            case "partly-cloudy-day": // Cloud cover is greater than 20% cover during day time.
                sun = night ? false : true
                rain = false
                clouds = .few
            case "partly-cloudy-night": // Cloud cover is greater than 20% cover during night time.
                sun = false
                rain = false
                clouds = .few
            case "clear-day": // Cloud cover is less than 20% cover during day time
                sun = night ? false : true
                rain = false
                clouds = .clear
            case "clear-night": // Cloud cover is less than 20% cover during night time
                sun = false
                rain = false
                clouds = .clear
            default:
                sun = !night
                rain = false
                clouds = .clear
            }
            
            if self.night != night {
                self.night = night
            }
            if self.sun != sun {
                self.sun = sun
            }
            if self.rain != rain {
                self.rain = rain
            }
            if self.clouds != clouds {
                self.clouds = clouds
            }
        }
    }
}

