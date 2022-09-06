//
//  MapLocationsSheetView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 25/08/2022.
//

import SwiftUI

struct MapLocationsSheetView: View {
    
    @EnvironmentObject var model: TemperatureViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    let mockLocations: [IdentifiableLocationTemperature]?
    var locations: [IdentifiableLocationTemperature] {
        if let mockLocations = mockLocations {
            return mockLocations
        }
        
        guard let locationViewModels = model.locationViewModel?.weatherViewModel?.locationViewModels else {
            return []
        }
        return locationViewModels.map {
            IdentifiableLocationTemperature(name: $0.name, temperature: $0.temperature)
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "EDF0E0"))
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 0) {
                    Image(systemName: "thermometer")
                        .font(.system(size: UIFontMetrics.default.scaledValue(for: 29)))
                        .padding(.leading, 8)
                        .padding(.trailing)
                    
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Temperature")
                            .font(.system(size: UIFontMetrics.default.scaledValue(for: 16), weight: .semibold))
                        
                        Text("Your Locations")
                            .font(.system(size: UIFontMetrics.default.scaledValue(for: 14), weight: .regular))
                            .foregroundColor(Color(hex: "767878"))
                    }
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30, weight: .light))
                            .foregroundStyle(Color(hex: "7F8081"), .green, Color(hex: "E0E2DA"))
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(locations) { location in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(location.name)
                                        .font(.body)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text(location.temperature)
                                        .font(.body)
                                        .foregroundColor(Color(hex: "767878"))
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(.white)
                                HStack {
                                    Color.white
                                        .frame(width: 20, height: 1.5)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
    struct IdentifiableLocationTemperature: Identifiable {
        let id = UUID()
        let name: String
        let temperature: String
    }
}

struct MapLocationsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherViewModel = WeatherViewModel(isUsingMockData: true)
        let viewModel = weatherViewModel.selectedLocationViewModel.temperatureViewModel
        let mockLocations = [
            MapLocationsSheetView.IdentifiableLocationTemperature(name: "London", temperature: "21°"),
            MapLocationsSheetView.IdentifiableLocationTemperature(name: "Sydney", temperature: "32°"),
            MapLocationsSheetView.IdentifiableLocationTemperature(name: "North pole", temperature: "-45°")
        ]
        MapLocationsSheetView(mockLocations: mockLocations)
            .environmentObject(viewModel)
    }
}
