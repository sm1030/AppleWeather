//
//  LocationSubtitleView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 09/08/2022.
//

import SwiftUI

struct LocationSubtitleView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    @Binding var scrollViewPosition: CGFloat
    
    private let topMargin: CGFloat = 55
    private let titleTopMargin: CGFloat = 10
    private let topFullOpacityPoint: CGFloat = -100
    private let bottomFullOpacityPoint: CGFloat = 0
    private let topNoOpacityPoint: CGFloat = -130
    private let bottomNoOpacityPoint: CGFloat = -90
    
    private var offset: CGFloat {
        let zerroPoint = scrollViewPosition + titleTopMargin
        if zerroPoint > 0 {
            return topMargin + titleTopMargin + (zerroPoint/5)
        } else {
            return topMargin + titleTopMargin + (zerroPoint/5)
        }
    }
    
    private var topOpacity: CGFloat {
        if topNoOpacityPoint > scrollViewPosition {
            return 0
        } else if topFullOpacityPoint < scrollViewPosition {
            return 1
        } else {
            return (topNoOpacityPoint - scrollViewPosition) / (topNoOpacityPoint - topFullOpacityPoint)
        }
    }
    
    private var bottomOpacity: CGFloat {
        if bottomNoOpacityPoint > scrollViewPosition {
            return 0
        } else if bottomFullOpacityPoint < scrollViewPosition {
            return 1
        } else {
            return (bottomNoOpacityPoint - scrollViewPosition) / (bottomNoOpacityPoint - bottomFullOpacityPoint)
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(locationViewModel.temperature)
                .font(.system(size: 70).weight(.thin))
                .foregroundColor(.white)
                .offset(x: 5)
                .padding(.bottom, -16)
                .opacity(topOpacity)
            
            Text(locationViewModel.conditions)
                .opacity(locationViewModel.isDataLoaded ? bottomOpacity : 0)
                .font(.body)
                .foregroundColor(.white)
            
            Text("H:\(locationViewModel.temperatureHigh)  L:\(locationViewModel.temperatureLow)")
                .opacity(locationViewModel.isDataLoaded ? bottomOpacity : 0)
                .font(.body)
                .foregroundColor(.white)
                .padding(.top, -7)
            
            Spacer()
        }
        .offset(y: offset)
    }
}

struct LocationSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "6CA1C8"))
                .ignoresSafeArea()
            
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            LocationSubtitleView(scrollViewPosition: .constant(0))
                .environmentObject(weatherViewModel.selectedLocationViewModel)
        }
    }
}
