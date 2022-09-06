//
//  FewClouds.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 30/08/2022.
//

import SwiftUI

struct FewCloudsView: View {
    
    let night: Bool
    
    var travelDuration = Double(100)
    
    @State private var travel = false
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let cloudFileName = night ? "cloud-night" : "cloud-day"
            ZStack {
                Image(cloudFileName)
                    .resizable()
                    .scaledToFit()
                    .offset(x: -screenWidth * 1.3)
                
                Image(cloudFileName)
                    .resizable()
                    .scaledToFit()
                
                Image(cloudFileName)
                    .resizable()
                    .scaledToFit()
                    .offset(x: screenWidth * 1.3)
            }
            .offset(x: travel ? -screenWidth * 0.65 : screenWidth * 0.65, y: -10)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: travelDuration).repeatForever()) {
                        travel.toggle()
                    }
                }
            }
                
        }
    }
}

struct FewCloudsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4288B6")
                .ignoresSafeArea()
            FewCloudsView(night: false)
        }
    }
}

