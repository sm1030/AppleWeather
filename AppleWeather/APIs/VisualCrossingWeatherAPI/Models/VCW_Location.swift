//
//  VCW_Location.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

struct VCW_Location: Decodable {
    let latitude: Float // 40.7146,
    let longitude: Float // -74.0071,
    let resolvedAddress: String // "New York, NY, United States",
    let address: String // "new_york",
    let timezone: String // "America/New_York",
    let tzoffset: Float? // -4.0,
    let description: String // "Similar temperatures continuing with a chance of rain tomorrow & Wednesday.",
    let days: [VCW_Day]
    
    init(address: String) {
        self.latitude = 0
        self.longitude = 0
        self.resolvedAddress = ""
        self.address = address
        self.timezone = ""
        self.tzoffset = nil
        self.description = ""
        self.days = []
    }
}
