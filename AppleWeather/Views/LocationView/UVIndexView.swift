//
//  UVIndexView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 16/08/2022.
//

import SwiftUI

struct UVIndexView: View {
    @EnvironmentObject var model: UVIndexViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(model.uvIndex)
                .font(.title2)
                .foregroundColor(.white)
                .padding(.top, 1)
            
            Text(model.uvLevel)
                .font(.headline)
                .foregroundColor(.white)
            
            ScaleView(colors: model.scaleColors, value: model.scaleValue)
                .padding(.top, 20)
                .padding(.bottom, 15)
            
            Text(model.message)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.top, 2)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct UVIndexView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            let uvIndexViewModel = weatherViewModel.selectedLocationViewModel.uvIndexViewModel
            UVIndexView()
                .environmentObject(uvIndexViewModel)
        }
    }
}
