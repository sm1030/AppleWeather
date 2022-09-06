//
//  TestHelper.swift
//  AppleWeatherTests
//
//  Created by Alexandre Malkov on 14/08/2022.
//

import XCTest
@testable import AppleWeather

class TestHelper {
    class func makeVcwLocation(with assetName: String) throws -> VCW_Location? {
        let mockedData = try XCTUnwrap(NSDataAsset(name: assetName, bundle: Bundle(for: VCWTests.self))?.data)
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(VCW_Location.self, from: mockedData)
        } catch let error {
            XCTAssertThrowsError(error)
        }
        return nil
    }
}
