//
//  VCWTests.swift
//  AppleWeatherTests
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import XCTest
@testable import AppleWeather

class VCWTests: XCTestCase {
    
    var vcw: VCW?

    override func setUpWithError() throws {
        vcw = VCW()
    }

    override func tearDownWithError() throws {
        vcw = nil
    }

    func testLondonWeather() throws {
        try locationTest(assetName: "LondonWeather")
    }
    
    func testNewYorkWeather() throws {
        try locationTest(assetName: "NewYorkWeather")
    }
    
    func testSantiagoWeather() throws {
        try locationTest(assetName: "SantiagoWeather")
    }
    
    func testSydneyWeather() throws {
        try locationTest(assetName: "SydneyWeather")
    }
    
    func testTokyoWeather() throws {
        try locationTest(assetName: "TokyoWeather")
    }
    
    func locationTest(assetName: String) throws {
        let mockedData = try XCTUnwrap(NSDataAsset(name: assetName, bundle: Bundle(for: VCWTests.self))?.data)
        vcw?.getWeather(at: "", mockedData: mockedData, completion: { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                print(error)
                XCTFail(error.localizedDescription)
            }
        })
    }
}
