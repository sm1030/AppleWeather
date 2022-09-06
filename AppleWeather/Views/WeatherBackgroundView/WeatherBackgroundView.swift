//
//  WeatherBackgroundView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 07/08/2022.
//

import SwiftUI

struct WeatherBackgroundView: View {
    @EnvironmentObject var model: WeatherBackgroundViewModel
    
    var body: some View {
        ZStack {
            
            // MARK: The sky
            ZStack {
                // MARK: Night sky
                Rectangle()
                    .fill( LinearGradient(gradient: Gradient(colors: [Color(hex: "0C0C13"), Color(hex: "2B303F")]), startPoint: .top, endPoint: .bottom)
                    )
                    .ignoresSafeArea()

                // MARK: Stars
                if model.night && model.clouds != .overcast {
                    NightSkyWithStartsView()
                }

                // MARK: Day sky
                Rectangle()
                    .fill( LinearGradient(gradient: Gradient(colors: [Color(hex: "4288B6"), Color(hex: "70A4C5")]), startPoint: .top, endPoint: .bottom))
                    .opacity(model.night ? 0 : 1)
                    .ignoresSafeArea()
            }

            // MARK: Sunrays
            if model.sun {
                ZStack {
                    SunRayView()
                    SunRayView()
                    SunRayView()
                    SunRayView()
                    SunRayView()
                }
            }

            // MARK: Sunglares
            if model.sun {
                ZStack {
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                    SunGlareView()
                }
            }

            // MARK: The Sun
            if model.sun {
                TheSunInTheCorner()
            }

            // MARK: The rain
            if model.rain {
                TheRainView(night: model.night)
            }

            // MARK: Cloud layer
            switch model.clouds {
            case .clear:
                Color.clear
            case .few:
                FewCloudsView(night: model.night)
            case .overcast:
                OvercastCloudsView()
            }
        }
        .animation(.linear(duration: 1), value: model.night)
        .animation(.linear(duration: 1), value: model.sun)
        .animation(.linear(duration: 1), value: model.rain)
        .animation(.linear(duration: 1), value: model.clouds)
    }
}

struct WeatherBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherViewModel = WeatherViewModel(isUsingMockData: true)
        WeatherBackgroundView()
            .environmentObject(weatherViewModel.weatherBackgroundViewModel)
    }
}
