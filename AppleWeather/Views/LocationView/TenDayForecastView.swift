//
//  TenDayForecast.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 12/08/2022.
//

import SwiftUI

struct TenDayForecastView: View {
    @EnvironmentObject var model: TenDayForecastViewModel

    var body: some View {
        VStack() {
            ForEach(model.days) {day in
                VStack() {
                    Color(hex: "cfffff").opacity(0.5).blendMode(.lighten)
                        .frame(height: 1)
                    ZStack {
                        // This invisible stack will provide all rows with the same height
                        VStack {
                            WeatherIconView(vcwIconName: "rain")
                                .font(.body)
                            Text("0")
                                .font(.footnote)
                        }
                        .padding(.vertical, 1)
                        .opacity(0)

                        // The real content
                        HStack(alignment: .center, spacing: 0) {
                            ZStack(alignment: .leading) {
                                Text(day.dayOfWeek)
                                    .font(.body).fontWeight(.medium)
                                    .foregroundColor(.white)

                                // We will use this hidden text to ensure same width for all items
                                Text("Today")
                                    .font(.body).fontWeight(.medium)
                                    .opacity(0)
                            }

                            Spacer()

                            if let precipProb = day.precipProb {
                                VStack {
                                    WeatherIconView(vcwIconName: day.icon)
                                        .font(.body)
                                    Text(precipProb)
                                        .font(.footnote)
                                        .foregroundColor(.lightBlue)
                                }
                            } else {
                                WeatherIconView(vcwIconName: day.icon)
                                    .font(.body)
                            }

                            Spacer()

                            Text(day.minTemp)
                                .font(.body).fontWeight(.medium)
                                .foregroundColor(Color(hex: "cfffff")).opacity(0.5).blendMode(.lighten)

                            HStack(alignment: .center, spacing: 0) {
                                ForEach(day.tempGradient) { identifiableColor in
                                    Rectangle()
                                        .fill(identifiableColor.color)
                                        .frame(height: 4)

                                }
                            }
                            .frame(width: 50)
                            .padding()

                            Text(day.maxTemp)
                                .font(.body).fontWeight(.medium)
                                .foregroundColor(.white)

                        }
                        .padding(.vertical, 1)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct LocationTenDayForecast_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            let tenDayForecastViewModel = weatherViewModel.locationViewModels.first?.tenDayForecastViewModel
            TenDayForecastView()
                .environmentObject(tenDayForecastViewModel!)
        }
    }
}
