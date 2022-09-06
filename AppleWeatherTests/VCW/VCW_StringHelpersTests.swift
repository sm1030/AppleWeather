//
//  VCW_StringHelpersTests.swift
//  AppleWeatherTests
//
//  Created by Alexandre Malkov on 14/08/2022.
//

import XCTest
@testable import AppleWeather

class VCW_StringHelpersTests: XCTestCase {
    
    func testVcwTimeStringToSeconds() throws {
        XCTAssertEqual("05:34:47".vcwTimeStringToSeconds(), 20087)
        XCTAssertEqual("05:34".vcwTimeStringToSeconds(), nil)
        XCTAssertEqual("2020-08-10".vcwTimeStringToSeconds(), nil)
        XCTAssertEqual("2020-08".vcwTimeStringToSeconds(), nil)
    }
    
    func testVcwTimeStringToHours() throws {
        XCTAssertEqual("05:34:47".vcwTimeStringToHours(), 5)
        XCTAssertEqual("05:34".vcwTimeStringToHours(), nil)
        XCTAssertEqual("2020-08-10".vcwTimeStringToHours(), nil)
        XCTAssertEqual("2020-08".vcwTimeStringToHours(), nil)
    }
    
    func testVCW_DateStringToDayOfWeek() throws {
        XCTAssertEqual("2020-08-10".vcwDateStringToDayOfWeek(), "Mon")
        XCTAssertEqual("2020-08-11".vcwDateStringToDayOfWeek(), "Tue")
        XCTAssertEqual("2020-08-12".vcwDateStringToDayOfWeek(), "Wed")
        XCTAssertEqual("2020-08-13".vcwDateStringToDayOfWeek(), "Thu")
        XCTAssertEqual("2020-08-14".vcwDateStringToDayOfWeek(), "Fri")
        XCTAssertEqual("2020-08-15".vcwDateStringToDayOfWeek(), "Sat")
        XCTAssertEqual("2020-08-16".vcwDateStringToDayOfWeek(), "Sun")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())
        XCTAssertEqual(today.vcwDateStringToDayOfWeek(), "Today")
    }
    
    func testTemperatureString() throws {
        XCTAssertEqual(String(vcw_temperature: nil, temperatureScale: .celsius), "--")
        XCTAssertEqual(String(vcw_temperature: -10, temperatureScale: .celsius), "-10°")
        XCTAssertEqual(String(vcw_temperature: 0, temperatureScale: .celsius), "0°")
        XCTAssertEqual(String(vcw_temperature: 10, temperatureScale: .celsius), "10°")
        
        XCTAssertEqual(String(vcw_temperature: nil, temperatureScale: .fahrenheit), "--")
        XCTAssertEqual(String(vcw_temperature: -10, temperatureScale: .fahrenheit), "14°")
        XCTAssertEqual(String(vcw_temperature: 0, temperatureScale: .fahrenheit), "32°")
        XCTAssertEqual(String(vcw_temperature: 10, temperatureScale: .fahrenheit), "50°")
    }
}

