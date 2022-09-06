//
//  CityList_LocationSummaryView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 02/09/2022.
//

import Foundation

import SwiftUI

struct CityList_LocationSummaryView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    @State var weatherBackgroundViewModel = WeatherBackgroundViewModel()
    @State var timeString = "00:00"
    
    let viewHeight: CGFloat = 110
    
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
                    
                    Text(locationViewModel.conditions)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Right side items
                VStack(alignment: .trailing, spacing: 0) {
                    Text(locationViewModel.temperature)
                        .font(.system(size: 47).weight(.light))
                        .foregroundColor(.white)
                        .padding(.top, -5)
                    
                    Spacer()
                    
                    Text("H:\(locationViewModel.temperatureHigh)  L:\(locationViewModel.temperatureLow)")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .frame(height: viewHeight)
        .cornerRadius(20)
    }
}

struct CityList_LocationSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "000000"))
                .ignoresSafeArea()
            
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            CityList_LocationSummaryView()
                .environmentObject(weatherViewModel.locationViewModels[0])
        }
    }
}

