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
        XCTAssertEqual(firstLocationViewModel.name, "London")
        XCTAssertEqual(firstLocationViewModel.temperature, "28°")
        XCTAssertEqual(firstLocationViewModel.conditions, "Partially Cloudy")
        XCTAssertEqual(firstLocationViewModel.isDataLoaded, true)
    }
}
