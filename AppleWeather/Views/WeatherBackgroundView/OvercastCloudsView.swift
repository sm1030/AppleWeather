//
//  OvercastCloudsView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 30/08/2022.
//

import SwiftUI

struct OvercastCloudsView: View {
    
    var travelDuration = Double(100)
    
    @State private var travel = false
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            ZStack {
                Image("cloud-day")
                    .resizable()
                    .scaledToFill()
                    .offset(x: -screenWidth*3, y: -screenHeight * 0.5)
                
                Image("cloud-day")
                    .resizable()
                    .scaledToFill()
                    .offset(x: -screenWidth*2, y: -screenHeight * 0.5)
                
                Image("cloud-day")
                    .resizable()
                    .scaledToFill()
                    .offset(x: -screenWidth*1, y: -screenHeight * 0.5)
                
                Image("cloud-day")
                    .resizable()
                    .scaledToFill()
                    .offset(x: 0, y: -screenHeight * 0.5)
            }
            .offset(x: travel ? -screenWidth * 0.65 : screenWidth * 0.65)
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

struct OvercastCloudsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4288B6")
                .ignoresSafeArea()
            OvercastCloudsView()
        }
    }
}

