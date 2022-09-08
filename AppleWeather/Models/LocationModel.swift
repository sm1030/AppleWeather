//
//  LocationModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 13/08/2022.
//

import Foundation

class LocationModel {
    
    var location: VCW_Location
    
    var mockedData: Data?
    
    var asyncMode: Bool = true
    
    var updateResult: Result<VCW_Location, Error>?
    
    var lastUpdateTime: Date = Calendar.current.date( byAdding: .hour, value: -100, to: Date())!
    
    
    /// Create and instance of LocationModel for specific address
    /// - Parameter address: Location address string used by VCW API to find weather for this location. This is the same string that you enter in the search bar
    init(address: String, mockedData: Data? = nil, asyncMode: Bool = true) {
        self.mockedData = mockedData
        self.asyncMode = asyncMode
        self.location = VCW_Location(address: address)
    }
    
    var localTimeInSeconds: Int? {
        var calendar = Calendar.current
        guard let tzoffset = location.tzoffset, let timeZone = TimeZone(secondsFromGMT: Int(60*60*tzoffset)) else {
            return nil
        }
        calendar.timeZone = timeZone
        let date = Date()
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        return hours*3600 + minutes*60 + seconds
    }
    
    var localTimeHHmm: String? {
        guard let tzoffset = location.tzoffset, let timeZone = TimeZone(secondsFromGMT: Int(60*60*tzoffset)) else {
            return nil
        }
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var currentHourWeather: VCW_Hour? {
        if let currentTimeInSeconds = localTimeInSeconds {
            let currentHour = Int(currentTimeInSeconds / 3600)
            return location.days.first?.hours.first {
                $0.datetime.vcwTimeStringToHours() == currentHour
            }
        }
        return nil
    }
    
    var isNight: Bool {
        guard let localTimeInSeconds = localTimeInSeconds,
              let firstDay = location.days.first,
              let sunriseInSeconds = firstDay.sunrise.vcwTimeStringToSeconds(),
              let sunsetInSeconds = firstDay.sunset.vcwTimeStringToSeconds() else {
            return false
        }
        return localTimeInSeconds < sunriseInSeconds || localTimeInSeconds > sunsetInSeconds
    }

    func update(completion: @escaping ((Result<VCW_Location, Error>) -> ())) {
        if asyncMode {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                print("LocationModel.update for \(self.location.address)")
                self.updateResult = nil
                VCW().getWeather(at: self.location.address, mockedData: self.mockedData) { [weak self] result in
                    DispatchQueue.main.async {
                        self?.handleGetVeatherResponse(completion: completion, result: result)
                    }
                }
            }
        } else {
            VCW().getWeather(at: self.location.address, mockedData: self.mockedData) { [weak self] result in
                self?.handleGetVeatherResponse(completion: completion, result: result)
            }
        }
    }
    
    private func handleGetVeatherResponse(completion: @escaping ((Result<VCW_Location, Error>) -> ()), result: Result<VCW_Location, Error>) {
        self.updateResult = result
        switch result {
        case .success(let newLocationValue):
            print("LocationModel.update SUCCESS for \(self.location.address)")
            self.location = newLocationValue
        case .failure(let error):
            print("LocationModel.update ERROR for \(self.location.address)")
            print(error)
        }
        lastUpdateTime = Date()
        completion(result)
    }
}
