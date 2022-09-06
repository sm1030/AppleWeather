//
//  ContentTabBarBackgroundView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 07/08/2022.
//

import SwiftUI

struct ContentTabBackgroundView: View {
    var isNight: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Top border line
            Rectangle()
                .fill(Color(hex: "cfffff")).opacity(0.5).blendMode(.lighten)
                .frame(height:1)
            
            // Main background
            Rectangle()
                .fill(Color(hex: "60646F")).opacity(0.5).blendMode(.hardLight)
                .frame(height:49)
        }
    }
}

struct ContentTabBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ContentTabBackgroundView(isNight: true)
    }
}
