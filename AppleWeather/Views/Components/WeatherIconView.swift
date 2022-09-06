//
//  WeatherIcon.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 14/08/2022.
//

import SwiftUI

struct WeatherIconView: View {
    var vcwIconName: String
    
    var body: some View {
        switch vcwIconName {
        case "snow": // Amount of snow is greater than zero
            Image(systemName: "snowflake")
                .foregroundColor(.white)
        case "snow-showers-day": // Periods of snow during the day
            Image(systemName: "cloud.sun.rain.fill")
                .foregroundStyle(.white, .yellow, Color.lightBlue)
        case "snow-showers-night": // Periods of snow during the night
            Image(systemName: "cloud.moon.rain.fill")
                .foregroundStyle(.white, .white, Color.lightBlue)
        case "thunder-rain": // Thunderstorms throughout the day or night
            Image(systemName: "cloud.bolt.rain.fill")
                .foregroundStyle(.white, Color.lightBlue)
        case "thunder-showers-day": // Possible thunderstorms throughout the day
           Image(systemName: "cloud.sun.bolt.fill")
                .foregroundStyle(.white, .yellow)
        case "thunder-showers-night": // Possible thunderstorms throughout the night
            Image(systemName: "cloud.moon.bolt.fill")
                .foregroundStyle(.white, .white)
        case "rain": // Amount of rainfall is greater than zero
            Image(systemName: "cloud.rain.fill")
                .foregroundStyle(.white, Color.lightBlue)
        case "showers-day": // Rain showers during the day
            Image(systemName: "cloud.sun.rain.fill")
                .foregroundStyle(.white, .yellow, Color.lightBlue)
        case "showers-night": // Rain showers during the night
            Image(systemName: "cloud.moon.rain.fill")
                .foregroundStyle(.white, .white, Color.lightBlue)
        case "fog": // Visibility is low (lower than one kilometer or mile)
            Image(systemName: "cloud.fog.fill")
                .foregroundStyle(.white, .white)
        case "wind": // Wind speed is high (greater than 30 kph or mph)
            Image(systemName: "wind")
                .foregroundStyle(.white)
        case "cloudy": // Cloud cover is greater than 90% cover
            Image(systemName: "cloud.fill")
                .foregroundStyle(.white)
        case "partly-cloudy-day": // Cloud cover is greater than 20% cover during day time.
            Image(systemName: "cloud.sun.fill")
                .foregroundStyle(.white, .yellow)
        case "partly-cloudy-night": // Cloud cover is greater than 20% cover during night time.
            Image(systemName: "cloud.moon.fill")
                .foregroundStyle(.white, .white)
        case "clear-day": // Cloud cover is less than 20% cover during day time
            Image(systemName: "sun.max.fill")
                .foregroundStyle(.yellow)
        case "clear-night": // Cloud cover is less than 20% cover during night time
            Image(systemName: "moon.fill")
                .foregroundStyle(.white)
        case "sunrise":
            Image(systemName: "sunrise.fill")
                .foregroundStyle(.white, .yellow)
        case "sunset":
            Image(systemName: "sunset.fill")
                .foregroundStyle(.white, .yellow)
        default:
            Image(systemName: vcwIconName)
        }
    }
}

struct WeatherIconView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            VStack {
                VStack {
                    WeatherIconView(vcwIconName: "snow")
                    WeatherIconView(vcwIconName: "snow-showers-day")
                    WeatherIconView(vcwIconName: "snow-showers-night")
                    WeatherIconView(vcwIconName: "thunder-rain")
                    WeatherIconView(vcwIconName: "thunder-showers-day")
                    WeatherIconView(vcwIconName: "thunder-showers-night")
                    WeatherIconView(vcwIconName: "rain")
                    WeatherIconView(vcwIconName: "showers-day")
                    WeatherIconView(vcwIconName: "showers-night")
                }
                VStack {
                    WeatherIconView(vcwIconName: "fog")
                    WeatherIconView(vcwIconName: "wind")
                    WeatherIconView(vcwIconName: "cloudy")
                    WeatherIconView(vcwIconName: "partly-cloudy-day")
                    WeatherIconView(vcwIconName: "partly-cloudy-night")
                    WeatherIconView(vcwIconName: "clear-day")
                    WeatherIconView(vcwIconName: "clear-night")
                    WeatherIconView(vcwIconName: "sunrise")
                    WeatherIconView(vcwIconName: "sunset")
                }
            }
        }
    }
}
