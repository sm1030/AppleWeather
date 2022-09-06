//
//  WindView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 18/08/2022.
//

import SwiftUI

struct WindView: View {
    @EnvironmentObject var model: WindViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {

            ZStack {
                CompasView(arrowDirectionDegrees: model.windDirectionInDegrees)
                
                VStack {
                    Text("N")
                    Spacer()
                    Text("S")
                }
                .foregroundColor(Color.greyBlue)
                .font(.system(size: 15))
                .padding(.vertical, 14)
                
                HStack {
                    Text("W")
                    Spacer()
                    Text("E")
                }
                .foregroundColor(Color(hex: "cfffff")).opacity(0.5).blendMode(.lighten)
                .font(.system(size: 15))
                .padding(.horizontal, 17)
                
                VStack(alignment: .center) {
                    Text(model.windSpeedValue)
                        .font(.system(size: 30)).fontWeight(.semibold)
                        .padding(.bottom, -15)
                    Text(model.windSpeedUnits)
                        .font(.system(size: 16))
                }
                .foregroundColor(.white)
            }
            .frame(width: 108, height: 108, alignment: .center)

        }
//        .frame(height: 160)
        .padding(.horizontal)
    }
}

struct WindView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            let uvIndexViewModel = weatherViewModel.selectedLocationViewModel.uvIndexViewModel
            WindView()
                .environmentObject(uvIndexViewModel)
        }
    }
}
