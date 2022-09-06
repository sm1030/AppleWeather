//
//  VCW_Day.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

struct VCW_Day: Decodable {
    let datetime: String // "2022-08-08",
    let datetimeEpoch: Int // 1659931200,
    let tempmax: Float // 36.7,
    let tempmin: Float // 26.3,
    let temp: Float // 31.3,
    let feelslikemax: Float // 37.8,
    let feelslikemin: Float // 26.3,
    let feelslike: Float // 33.1,
    let dew: Float // 20.3,
    let humidity: Float // 55.4,
    let precip: Float // 0.0,
    let precipprob: Float // 95.2,
    let precipcover: Float // 0.0,
    let preciptype: [String]? // ["rain"],
    let snow: Float? // 0.0,
    let snowdepth: Float? // 0.0,
    let windgust: Float // 41.0,
    let windspeed: Float // 21.2,
    let winddir: Float // 214.2,
    let pressure: Float // 1015.7,
    let cloudcover: Float // 19.7,
    let visibility: Float // 32.8,
    let solarradiation: Float // 249.8,
    let solarenergy: Float? // 21.8,
    let uvindex: Float // 8.0,
    let severerisk: Float // 30.0,
    let sunrise: String // "05:59:30",
    let sunriseEpoch: Int // 1659952770,
    let sunset: String // "20:03:15",
    let sunsetEpoch: Int // 1660003395,
    let moonphase: Float // 0.41,
    let conditions: String // "Rain",
    let description: String // "Clear conditions throughout the day with storms possible.",
    let icon: String // "rain",
    let stations: [String]? // ["KEWR", "KLGA","KNYC","F1417"],
    let source: String // comb",
    let hours: [VCW_Hour]
}
