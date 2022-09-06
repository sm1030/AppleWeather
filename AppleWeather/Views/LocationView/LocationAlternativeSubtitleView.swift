//
//  LocationAlternativeSubtitleView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 09/08/2022.
//

import SwiftUI

struct LocationAlternativeSubtitleView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    @Binding var scrollViewPosition: CGFloat
    
    private let topMargin: CGFloat = 40
    private let titleTopMargin: CGFloat = 10
    private let fullOpacityPoint: CGFloat = -180
    private let noOpacityPoint: CGFloat = -120
    
    private var offset: CGFloat {
        topMargin + titleTopMargin
    }
    
    private var opacity: CGFloat {
        if scrollViewPosition > noOpacityPoint {
            return 0
        } else if scrollViewPosition < fullOpacityPoint {
            return 1
        } else {
            return (noOpacityPoint - scrollViewPosition) / (noOpacityPoint - fullOpacityPoint)
        }
    }
    
    var body: some View {
        VStack {
            Text("\(locationViewModel.temperature)  |  \(locationViewModel.conditions)")
                .font(.system(size: UIFontMetrics.default.scaledValue(for: 18)))
                .foregroundColor(.white)
            Spacer()
        }
        .offset(y: offset)
        .opacity(opacity)
    }
}

struct LocationAlternativeSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "6CA1C8"))
                .ignoresSafeArea()
            
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            LocationAlternativeSubtitleView(scrollViewPosition: .constant(-200))
                .environmentObject(weatherViewModel.selectedLocationViewModel)
        }
    }
}
