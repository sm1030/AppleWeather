//
//  MapTemperatureBadgeView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 25/08/2022.
//

import SwiftUI

struct MapTemperatureBadgeView: View {
    
    @EnvironmentObject var model: MapViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                
                let gradient = AngularGradient(colors: model.tempGradientColors,
                                               center: .center,
                                               startAngle: .degrees(180),
                                               endAngle: .degrees(360))
                Circle()
                    .trim(from: 0.15, to: 0.85)
                    .rotation(.degrees(90))
                    .stroke(gradient ,style: StrokeStyle(lineWidth: 4))
                    .frame(width: 50, height: 50)
                Text(String(vcw_temperature: Float(model.temperature)))
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                    .offset(x: (model.temperature > 0) ? 3: 0)
                Text("\(model.minTemperature)")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(model.tempGradientColors.first ?? .black)
                    .offset(x: -8, y: 18)
                Text("\(model.maxTemperature)")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(model.tempGradientColors.last ?? .black)
                    .offset(x: 8, y: 18)
            }
            
            Circle()
                .foregroundColor(.white)
                .frame(width: 8, height: 8)
            
            ZStack {
                ForEach([-1.2, 0, 1.2], id: \.self) { x in
                    ForEach([-1.2, 0, 1.2], id: \.self) { y in
                        Text(model.locationName)
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 1)
                            .offset(x: CGFloat(x), y: CGFloat(y))
                    }
                }
                
                Text(model.locationName)
                    .font(.caption2)
                    .foregroundColor(.black)
                    .padding(.horizontal, 1)
            }
        }
    }
}

struct MapTemperatureBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            let mapViewModel = weatherViewModel.selectedLocationViewModel.mapViewModel
            MapTemperatureBadgeView()
                .environmentObject(mapViewModel)
        }
    }
}
