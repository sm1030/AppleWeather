//
//  LocationTitleView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 09/08/2022.
//

import SwiftUI

struct LocationTitleView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    @Binding var scrollViewPosition: CGFloat
    
    private let fixedTopMargin: CGFloat = 10
    private let shrinkableTopMargin: CGFloat = 130
    
    private var offsetPosition: CGFloat {
        if scrollViewPosition + shrinkableTopMargin > 0 {
            return fixedTopMargin + (scrollViewPosition + shrinkableTopMargin) / 5
        } else {
            return fixedTopMargin
        }
    }
    
    var body: some View {
        VStack {
            Text(locationViewModel.name)
                .font(.system(size: 34))
                .foregroundColor(.white)
            Spacer()
        }
        .offset(y: offsetPosition)
    }
}

struct LocationTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "6CA1C8"))
                .ignoresSafeArea()
            
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            LocationTitleView(scrollViewPosition: .constant(0))
                .environmentObject(weatherViewModel.selectedLocationViewModel)
        }
    }
}
