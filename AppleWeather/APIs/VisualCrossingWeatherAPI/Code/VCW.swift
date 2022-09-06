//
//  VCW.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

enum VCW_Error: Error {
    case nonJsonResponse(string: String)
}

class VCW {
    var VCW_key = "2BKWWZP6S6LEL5PJM2NTW78X5"
    var mockableURLRequest = MockableURLRequest()
    
    func getWeather(at address: String, mockedData: Data?, completion: @escaping ((Result<VCW_Location, Error>) -> ())) {
        mockableURLRequest.mockedData = mockedData
        let formattedAddress = address.replacingOccurrences(of: " ", with: "_")
        if let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(formattedAddress)?unitGroup=metric&key=\(VCW_key)&iconSet=icons2&ntentType=json") {
            mockableURLRequest.request(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let string = String(decoding: data, as: UTF8.self)
                        guard string.prefix(1) == "{" else {
                            throw VCW_Error.nonJsonResponse(string: string)
                        }
                        let location = try jsonDecoder.decode(VCW_Location.self, from: data)
                        completion(.success(location))
                    } catch let error {
                        print(error)
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
