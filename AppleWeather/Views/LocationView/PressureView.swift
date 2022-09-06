//
//  PressureView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 19/08/2022.
//

import SwiftUI

struct PressureView: View {
    @EnvironmentObject var model: PressureViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {

            ZStack {
                ArcScaleView(value: pressureToScaleValue(pressure: model.pressure),
                             trailStart: pressureToScaleValue(pressure: model.minPressure),
                             trailEnd: pressureToScaleValue(pressure: model.maxPressure))
                
                VStack(alignment: .center) {
                    Image(systemName: model.directionSymbol)
                        .font(.headline)
                        .padding(.top, 12)
                        .padding(.bottom, -3)
                    
                    Text(model.pressureText)
                        .font(.headline)
                    
                    Text("hPa")
                        .font(.footnote)
                        .padding(.bottom, -18)
                    HStack(alignment: .center, spacing: 40) {
                        Text("Low")
                            .font(.footnote)
                        Text("High")
                            .font(.footnote)
                    }
                    .padding(.horizontal, -20)
                }
                .foregroundColor(.white)
            }
            .frame(width: 108, height: 108, alignment: .center)

        }
        .padding(.horizontal)
    }
    
    func pressureToScaleValue(pressure: Int) -> Float {
        if pressure > 0 {
            return Float(pressure - 1013) / 50
        } else {
            return 0
        }
    }
}

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            let pressureViewModel = weatherViewModel.selectedLocationViewModel.pressureViewModel
            PressureView()
                .environmentObject(pressureViewModel)
        }
    }
}
