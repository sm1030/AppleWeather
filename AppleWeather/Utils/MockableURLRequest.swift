//
//  MockableURLRequest.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 08/08/2022.
//

import Foundation

/// Lazy wrapper for URLSession where you can provide moc response data for unit testing
class MockableURLRequest {
    var mockedData: Data?
    var mockedURLResponse: URLResponse?
    var mockedError: Error?
    
    /// Execute for the URLSession.dataTask with resume() unless you set up mocked variables for this class instance.
    /// - Parameters:
    ///   - url: Remote URL string
    ///   - completionHandler: Completion handler, exactly the same as used with dataTask() function
    func request(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let mockedData = mockedData {
            completionHandler(mockedData, mockedURLResponse, mockedError)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                completionHandler(data, response, error)
            }
            .resume()
        }
    }
}

