//
//  WeatherLocationView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 07/08/2022.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    private let titleViewTopPadding: CGFloat = 10
    private let topFrameHeight: CGFloat = 150
    private let scrollViewTopPadding: CGFloat = 84
    
    @State private var scrollViewPosition: CGFloat = 0
    @State private var locationHourlyForecastViewGeometry: CGRect?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Three lines of weather condition such as: "20° /n Clear /n H:29°  L:14"
                LocationSubtitleView(scrollViewPosition: $scrollViewPosition)
                    .environmentObject(locationViewModel)
                
                // Location name such as: "London"
                LocationTitleView(scrollViewPosition: $scrollViewPosition)
                    .environmentObject(locationViewModel)
                
                // Alternative, one liner, weather condition such as: "23° | Sunny"
                LocationAlternativeSubtitleView(scrollViewPosition: $scrollViewPosition)
                    .environmentObject(locationViewModel)
                
                ScrollView(showsIndicators: false) {
                    Color.clear
                        .frame(width: 0, height: topFrameHeight)
                        .onItemFrameChanged(listGeometry: geometry) { (frame: CGRect?) in
                            scrollViewPosition = (frame?.origin.y ?? -topFrameHeight) - scrollViewTopPadding
                        }
                    
                    HourlyForecastView()
                        .stickyHeaderScrollBacground(titleText: "HOURLY FORECAST",
                                                     titleSFSymbol: "clock" ,
                                                     alternativeTitleText: locationViewModel.hourlyForecastViewModel.description)
                        .environmentObject(locationViewModel.hourlyForecastViewModel)

                    TenDayForecastView()
                        .stickyHeaderScrollBacground(titleText: "10-DAY FORECAST",
                                                     titleSFSymbol: "calendar")
                        .environmentObject(locationViewModel.tenDayForecastViewModel)

                    AirPollutionView()
                        .stickyHeaderScrollBacground(titleText: "AIR POLLUTION",
                                                     titleSFSymbol: "aqi.low")
                        .environmentObject(locationViewModel.airPollutionViewModel)

                    TemperatureView()
                        .stickyHeaderScrollBacground(titleText: "TEMPERATURE",
                                                     titleSFSymbol: "thermometer")
                        .environmentObject(locationViewModel.temperatureViewModel)

                    HStack(spacing: 12) {
                        UVIndexView()
                            .stickyHeaderScrollBacground(titleText: "UV INDEX",
                                                         titleSFSymbol: "sun.max.fill")
                            .environmentObject(locationViewModel.uvIndexViewModel)

                        SunsetView()
                            .stickyHeaderScrollBacground(titleText: locationViewModel.sunsetViewModel.titleText,
                                                         titleSFSymbol: locationViewModel.sunsetViewModel.titleSFSymbol)
                            .environmentObject(locationViewModel.sunsetViewModel)
                    }

                    HStack(spacing: 12) {
                        WindView()
                            .stickyHeaderScrollBacground(titleText: "WIND",
                                                         titleSFSymbol: "wind")
                            .environmentObject(locationViewModel.windViewModel)

                        TwoLineMessageView()
                            .stickyHeaderScrollBacground(titleText: "RAINFALL",
                                                         titleSFSymbol: "drop.fill")
                            .environmentObject(locationViewModel.rainfallViewModel as TwoLinesMessageViewModel)
                    }

                    HStack(spacing: 12) {
                        TwoLineMessageView()
                            .stickyHeaderScrollBacground(titleText: "FEELS LIKE",
                                                         titleSFSymbol: "thermometer")
                            .environmentObject(locationViewModel.feelsLikeViewModel as TwoLinesMessageViewModel)

                        TwoLineMessageView()
                            .stickyHeaderScrollBacground(titleText: "HUMIDITY",
                                                         titleSFSymbol: "humidity")
                            .environmentObject(locationViewModel.humidityViewModel as TwoLinesMessageViewModel)
                    }

                    HStack(spacing: 12) {
                        TwoLineMessageView()
                            .stickyHeaderScrollBacground(titleText: "VISIBILITY",
                                                         titleSFSymbol: "eye.fill")
                            .environmentObject(locationViewModel.visibilityViewModel as TwoLinesMessageViewModel)

                        PressureView()
                            .stickyHeaderScrollBacground(titleText: "PRESSURE",
                                                         titleSFSymbol: "gauge")
                            .environmentObject(locationViewModel.pressureViewModel)
                    }

                    VStack {
                        Color(hex: "cfffff").opacity(0.5).blendMode(.lighten)
                            .frame(height: 1)

                        Text("Weather for \(locationViewModel.resolvedAddress)")
                            .multilineTextAlignment(.center)
                            .font(.footnote.weight(.bold))
                            .foregroundColor(.white)
                            .opacity(locationViewModel.isDataLoaded ? 1 : 0)
                            .padding(.bottom)
                    }
                }
                .opacity(locationViewModel.isDataLoaded ? 1 : 0)
                .coordinateSpace(name: "LocationScrollView")
                .padding(.top, scrollViewTopPadding)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 50)
            }
            .frame(
                width: geometry.size.width + geometry.safeAreaInsets.leading + geometry.safeAreaInsets.trailing,
                height: geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "6CA1C8"))
                .ignoresSafeArea()
            LocationView()
                .environmentObject(LocationViewModel(address: "", mockedData: NSDataAsset(name: "london")?.data))
        }
    }
}
