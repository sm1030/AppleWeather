//
//  WeatherViewModelTests.swift
//  AppleWeatherTests
//
//  Created by Alexandre Malkov on 29/08/2022.
//

import XCTest
@testable import AppleWeather

class WeatherViewModelTests: XCTestCase {
    
    var weatherViewModel: WeatherViewModel?

    @MainActor override func setUpWithError() throws {
        weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
    }

    @MainActor override func tearDownWithError() throws {
        weatherViewModel = nil
    }
    
    @MainActor func testVcwTimeStringToSeconds() throws {
        XCTAssertEqual(weatherViewModel?.locationViewModels.count, 5)
        
        let firstLocationViewModel = try XCTUnwrap(weatherViewModel?.locationViewModels.first)
        let currentHourWeather = try XCTUnwrap(firstLocationViewModel.locationModel.currentHourWeather)
        XCTAssertEqual(firstLocationViewModel.name, "London")
        XCTAssertEqual(firstLocationViewModel.temperature, String(vcw_temperature: currentHourWeather.temp))
        XCTAssertEqual(firstLocationViewModel.conditions, currentHourWeather.conditions)
        XCTAssertEqual(firstLocationViewModel.isDataLoaded, true)
    }
}
