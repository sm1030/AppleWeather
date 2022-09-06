//
//  VCW_Hour.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

struct VCW_Hour: Decodable {
    let datetime: String // "00:00:00",
    let datetimeEpoch: Int // 1659880800,
    let temp: Float // 11.8,
    let feelslike: Float // 11.8,
    let humidity: Float // 72.1,
    let dew: Float // 6.9,
    let precip: Float // 0.0,
    let precipprob: Float // 0.0,
    let snow: Float? // 0.0,
    let snowdepth: Float? // 0.0,
    let preciptype: [String]? // ":null,
    let windgust: Float // 27.7,
    let windspeed: Float // 14.4,
    let winddir: Float // 250.0,
    let pressure: Float // 1020.0,
    let visibility: Float // 10.0,
    let cloudcover: Float // 88.0,
    let solarradiation: Float // 0.0,
    let solarenergy: Float? // null,
    let uvindex: Float // 0.0,
    let severerisk: Float // 10.0,
    let conditions: String // "Partially cloudy",
    let icon: String // "partly-cloudy-night",
    let stations: [String]? // ["YSRI", "YSSY"],
    let source: String // "obs"
}
