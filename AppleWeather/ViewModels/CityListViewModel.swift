//
//  CityListViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 01/09/2022.
//

import SwiftUI
import Foundation

@MainActor final class CityListViewModel: ObservableObject {

    @Published var editMode = EditMode.inactive
    @Published var searchTextFieldIsFocused: Bool = false
    @Published var searchTextLengh: Int = 0
    @Published var searchResults: [City] = []
    @Published var previewLocationViewModel: LocationViewModel = LocationViewModel(address: "")
    @Published var previewWeatherBackgroundViewModel = WeatherBackgroundViewModel()
    @Published var searchResultsDisplayMode: SearchResultsDisplayMode = .none
    @Published var isShowingAlert = false
    @Published var alertMessage = ""
    
    weak var weatherViewModel: WeatherViewModel?
    
    var allCities: [City] = []
    var searchText: String = ""
    
    enum SearchResultsDisplayMode {
        case none
        case solidBackground
        case noResultsFound
        case showSearchResults
    }
    
    init() {
        loadCountryCitiesSet()
    }
    
    func loadCountryCitiesSet() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let data = NSDataAsset(name: "cities")?.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let allCities = try jsonDecoder.decode([City].self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.allCities = allCities
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func searchTextHaveChabged(searchText: String) {
        self.searchText = searchText
        searchTextLengh = searchText.count
        let vcwAddress = searchText.lowercased().replacingOccurrences(of: " ", with: "_")
        let allResults = allCities.filter { $0.vcwAddress.starts(with: vcwAddress) }
        if allResults.count > 50 {
            searchResults = Array(allResults.prefix(upTo: 50))
        } else {
            searchResults = allResults
        }
    }
    
    // If searchText have changed then call searchTextHaveChabged() before calling this method
    func updateSearchResultsDisplayMode() {
        if searchTextLengh == 0 {
            searchResultsDisplayMode = searchTextFieldIsFocused ? .solidBackground : .none
        } else if searchTextLengh == 1 || searchResults.count == 0 {
            searchResultsDisplayMode = .noResultsFound
        } else {
            searchResultsDisplayMode = .showSearchResults
        }
    }
    
    func previewLocation(with vcwAddress: String) {
        previewLocationViewModel = LocationViewModel(address: vcwAddress)
        previewLocationViewModel.fetchLatestWeatherInformation { [weak self] result in
            if let self = self {
                switch result {
                case .success(_):
                    self.previewWeatherBackgroundViewModel.publish(locationViewModel: self.previewLocationViewModel)
                case .failure(let error):
                    if self.isShowingAlert == false {
                        if let vcwError = error as? VCW_Error, case .nonJsonResponse(let string) = vcwError {
                            if string.starts(with: "You have exceeded the maximum number of daily result records") {
                                self.alertMessage = "This Visual Crossing Weather API account have exceeded the maximum number of daily requests. You can get your own free Visual Crossing Weather token from www.visualcrossing.com or you can use offline mock data"
                            } else {
                                self.alertMessage = string
                            }
                        } else {
                            self.alertMessage = error.localizedDescription
                        }
                        self.isShowingAlert.toggle()
                    }
                }
            }
        }
    }
}

struct City: Hashable, Identifiable, Decodable {
    // City data, stored locally, is taken from here https://pkgstore.datahub.io/core/world-cities/world-cities_json/data/5b3dd46ad10990bca47b04b4739a02ba/world-cities_json.json
    // {"country": "Andorra", "geonameid": 3040051, "name": "les Escaldes", "subcountry": "Escaldes-Engordany"}
    let geonameid: Int
    let name: String
    let country: String
    let subcountry: String?
    
    var id: Int {
        geonameid
    }
    
    var vcwAddress: String {
        return "\(name.lowercased()) \(country.lowercased())"
            .folding(options: .diacriticInsensitive, locale: .current)
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "’", with: "")
    }
    
    var displayName: String {
        if let subcountry = subcountry {
            return "\(name), \(subcountry), \(country)"
        } else {
            return "\(name) \(country)"
        }
    }
}
