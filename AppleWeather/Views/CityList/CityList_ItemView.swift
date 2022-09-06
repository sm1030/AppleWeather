//
//  CityList_ItemView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 02/09/2022.
//

import Foundation

import SwiftUI

struct CityList_ItemView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var cityListViewModel: CityListViewModel
    
    @State var weatherBackgroundViewModel = WeatherBackgroundViewModel()
    @State var timeString = "00:00"
    
    var viewHeight: CGFloat = 110
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    func updateTimeString() {
        if let hhmm = locationViewModel.locationModel.localTimeHHmm {
            timeString = hhmm
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                .overlay {
                    WeatherBackgroundView()
                        .environmentObject(weatherBackgroundViewModel)
                        .onAppear {
                            weatherBackgroundViewModel.publish(locationViewModel: locationViewModel)
                        }
                        .frame(height: viewHeight + 400)
                        .offset(y: 200)
                }
            
            HStack(spacing: 0) {
                
                // Left side items
                VStack(alignment: .leading, spacing: 0) {
                    Text(locationViewModel.name)
                        .font(.system(size: UIFontMetrics.default.scaledValue(for: 23)).weight(.semibold))
                        .foregroundColor(.white)
                    
                    Text(timeString)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .onReceive(timer) { time in
                            updateTimeString()
                        }
                        .onAppear {
                            updateTimeString()
                        }
                    
                    Spacer()
                    
                    if cityListViewModel.editMode == .inactive {
                        Text(locationViewModel.conditions)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                // Right side items
                VStack(alignment: .trailing, spacing: 0) {
                    Text(locationViewModel.temperature)
                        .font(.system(size: 47).weight(.light))
                        .foregroundColor(.white)
                        .padding(.top, -5)
                    
                    if cityListViewModel.editMode == .inactive {
                        Spacer()
                        Text("H:\(locationViewModel.temperatureHigh)  L:\(locationViewModel.temperatureLow)")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.top, 10)
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .cornerRadius(20)
        .animation(.linear(duration: 0.2), value: cityListViewModel.editMode)
    }
}

struct CityList_ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "000000"))
                .ignoresSafeArea()
            
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            CityList_ItemView()
                .environmentObject(weatherViewModel.locationViewModels[0])
                .environmentObject(weatherViewModel.cityListViewModel)
        }
    }
}

