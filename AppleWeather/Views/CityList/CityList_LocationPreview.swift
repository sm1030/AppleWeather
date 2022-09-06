//
//  CityList_LocationPreview.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 03/09/2022.
//

import SwiftUI

struct CityList_LocationPreview: View {
    
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @EnvironmentObject var cityListViewModel: CityListViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            WeatherBackgroundView()
                .environmentObject(cityListViewModel.previewWeatherBackgroundViewModel)
                .onAppear {
                    cityListViewModel.previewWeatherBackgroundViewModel.publish(locationViewModel: cityListViewModel.previewLocationViewModel)
                }
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        cityListViewModel.searchTextFieldIsFocused = true
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        cityListViewModel.addCity(locationViewModel: cityListViewModel.previewLocationViewModel)
                        cityListViewModel.searchText = ""
                        cityListViewModel.updateSearchResultsDisplayMode()
                        cityListViewModel.searchTextFieldIsFocused = false
                    } label: {
                        Text("Add")
                            .font(.body).fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                LocationView()
                    .environmentObject(cityListViewModel.previewLocationViewModel)
                    .padding(.bottom, -28)
                    .padding(.horizontal, -8)
                
            }
        }
    }
}

struct CityList_LocationPreview_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            let cityListViewModel = weatherViewModel.cityListViewModel
            CityList_LocationPreview()
                .environmentObject(weatherViewModel)
                .environmentObject(cityListViewModel)
                .onAppear {
                    cityListViewModel.previewLocationViewModel = weatherViewModel.selectedLocationViewModel
                }
        }
    }
}
