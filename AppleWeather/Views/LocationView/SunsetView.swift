//
//  SunsetView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 16/08/2022.
//

import SwiftUI

struct SunsetView: View {
    @EnvironmentObject var model: SunsetViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(model.topText)
                    .font(.title2)
                .foregroundColor(.white)
                .padding(.leading, 20)
                
                Spacer()
            }
            
            WaveView(sunriseInSeconds: model.sunriseInSeconds,
                     sunsetInSeconds: model.sunsetInSeconds,
                     sunPositionInSeconds: model.sunPositionInSeconds)
            Text(model.bottomText)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.bottom, 8)
        }
    }
}

struct SunsetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            let sunsetViewModel = weatherViewModel.selectedLocationViewModel.sunsetViewModel
            SunsetView()
                .environmentObject(sunsetViewModel)
        }
    }
}
