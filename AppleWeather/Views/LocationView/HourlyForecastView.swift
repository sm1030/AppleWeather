//
//  HourlyForecastView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 11/08/2022.
//

import SwiftUI

import SwiftUI

struct HourlyForecastView: View {
    @EnvironmentObject var model: HourlyForecastViewModel
    
    var body: some View {
        VStack {
            Color(hex: "cfffff").opacity(0.5).blendMode(.lighten)
                .frame(height: 1)
                .padding(.horizontal)
                .padding(.top, 15)
                .padding(.bottom, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(model.hours) {hour in
                        ZStack {
                            VStack(spacing: 0) {
                                Text(hour.hour)
                                    .font(.footnote).fontWeight(.medium)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                WeatherIconView(vcwIconName: hour.icon)
                                    .font(.headline)
                                
                                Spacer()
                                
                                if let precipProb = hour.precipProb {
                                    Text(precipProb)
                                        .font(.footnote)
                                        .foregroundColor(.lightBlue)
                                        .padding(.top, -12)
                                    
                                    Spacer()
                                }
                                
                                Text(hour.temp)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            
                            // Invisible text to keep cell width according with Dynamic Type font size
                            Text("000000")
                                .font(.caption2)
                                .opacity(0)
                        }
                    }
                }
                .frame(height: UIFontMetrics.default.scaledValue(for: 91))
                .padding(.horizontal)
            }
        }
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            let hourlyForecastViewModel = weatherViewModel.selectedLocationViewModel.hourlyForecastViewModel
            HourlyForecastView()
                .environmentObject(hourlyForecastViewModel)
        }
    }
}
