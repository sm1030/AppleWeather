//
//  ColorExtension.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 09/08/2022.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self.init(.displayP3, red: 0, green: 0, blue: 0, opacity: 0)
            return
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            self.init(.displayP3, red: 0, green: 0, blue: 0, opacity: 0)
            return
        }

        self.init(.displayP3, red: r, green: g, blue: b, opacity: a)
    }
    
    static let lightBlue = Color(hex: "85CBFE")
    static let deepBlue = Color(hex: "6FA6CD")
    static let greyBlue = Color(hex: "A9C2DC")
    
    static let airPollutionColors = [Color(hex: "65DB7C"),
                                     Color(hex: "65DA7C"),
                                     Color(hex: "65DA7B"),
                                     Color(hex: "6ACA66"),
                                     Color(hex: "7CBE56"),
                                     Color(hex: "A4B145"),
                                     Color(hex: "CDA33A"),
                                     Color(hex: "F09938"),
                                     Color(hex: "EC7B35"),
                                     Color(hex: "EA6439"),
                                     Color(hex: "E8523E"),
                                     Color(hex: "E64048"),
                                     Color(hex: "E43656"),
                                     Color(hex: "C62C96"),
                                     Color(hex: "AA23D5")]
}
