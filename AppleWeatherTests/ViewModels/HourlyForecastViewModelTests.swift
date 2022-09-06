//
//  HourlyForecastViewModelTests.swift
//  AppleWeatherTests
//
//  Created by Alexandre Malkov on 15/08/2022.
//

import XCTest
@testable import AppleWeather

class HourlyForecastViewModelTests: XCTestCase {
    
    var hourlyForecastViewModel: HourlyForecastViewModel?

    @MainActor override func setUpWithError() throws {
        let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
        let locationViewModel = weatherViewModel.selectedLocationViewModel
        hourlyForecastViewModel = HourlyForecastViewModel(mockLocalTimeInSeconds: 0)
        hourlyForecastViewModel?.publish(locationViewModel.locationModel)
    }

    @MainActor override func tearDownWithError() throws {
        hourlyForecastViewModel = nil
    }
    
    @MainActor func testVcwTimeStringToSeconds() throws {
        XCTAssertEqual(hourlyForecastViewModel?.description, "Similar temperatures continuing with no rain expected.")
        
        XCTAssertEqual(hourlyForecastViewModel?.hours.count, 26)
        
        let firstHour = try XCTUnwrap(hourlyForecastViewModel?.hours.first)
        XCTAssertEqual(firstHour.hour, "Now")
        XCTAssertEqual(firstHour.icon, "clear-night")
        XCTAssertEqual(firstHour.precipProb, nil)
        XCTAssertEqual(firstHour.temp, "20°")
        
        let sunriseHour = try XCTUnwrap(hourlyForecastViewModel?.hours.first{ $0.temp == "Sunrise"} )
        XCTAssertEqual(sunriseHour.hour, "5:34")
        XCTAssertEqual(sunriseHour.icon, "sunrise")
        XCTAssertEqual(sunriseHour.precipProb, nil)
        XCTAssertEqual(sunriseHour.temp, "Sunrise")
        
        let sunsetHour = try XCTUnwrap(hourlyForecastViewModel?.hours.first{ $0.temp == "Sunset"} )
        XCTAssertEqual(sunsetHour.hour, "20:36")
        XCTAssertEqual(sunsetHour.icon, "sunset")
        XCTAssertEqual(sunsetHour.precipProb, nil)
        XCTAssertEqual(sunsetHour.temp, "Sunset")
        
        let lastHour = try XCTUnwrap(hourlyForecastViewModel?.hours.last)
        XCTAssertEqual(lastHour.hour, "23")
        XCTAssertEqual(lastHour.icon, "clear-night")
        XCTAssertEqual(lastHour.precipProb, nil)
        XCTAssertEqual(lastHour.temp, "20°")
    }
}

