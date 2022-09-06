//
//  TenDayForecastViewModelTests.swift
//  AppleWeatherTests
//
//  Created by Alexandre Malkov on 14/08/2022.
//

import XCTest
@testable import AppleWeather

class TenDayForecastViewModelTests: XCTestCase {
    
    var tenDayForecastViewModel: TenDayForecastViewModel?

    @MainActor override func setUpWithError() throws {
        let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
        tenDayForecastViewModel = weatherViewModel.locationViewModels.first?.tenDayForecastViewModel
    }

    @MainActor override func tearDownWithError() throws {
        tenDayForecastViewModel = nil
    }
    
    @MainActor func testVcwTimeStringToSeconds() throws {
        XCTAssertEqual(tenDayForecastViewModel?.days.count, 10)
        
        let firstDay = try XCTUnwrap(tenDayForecastViewModel?.days.first)
        XCTAssertEqual(firstDay.dayOfWeek, "Mon")
        XCTAssertEqual(firstDay.icon, "clear-day")
        XCTAssertEqual(firstDay.precipProb, nil)
        XCTAssertEqual(firstDay.minTemp, "16°")
        XCTAssertEqual(firstDay.maxTemp, "28°")
        XCTAssertEqual(firstDay.tempGradient.count, 22)
        
        let lastDay = try XCTUnwrap(tenDayForecastViewModel?.days.last)
        XCTAssertEqual(lastDay.dayOfWeek, "Wed")
        XCTAssertEqual(lastDay.icon, "partly-cloudy-day")
        XCTAssertEqual(lastDay.precipProb, nil)
        XCTAssertEqual(lastDay.minTemp, "13°")
        XCTAssertEqual(lastDay.maxTemp, "23°")
        XCTAssertEqual(lastDay.tempGradient.count, 22)
    }
}
