//
//  SunGlareView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 30/08/2022.
//

import SwiftUI

struct SunGlareView: View {
    var glareWidth = CGFloat.random(in: 10...100)
    var glareDistanceAwayFromCorner = CGFloat.random(in: 50...300)
    var glareTravelDistance = CGFloat.random(in: 50...100)
    var glareTravelDuration = Double.random(in: 10 ... 20)
    var glareHideDuration = Double.random(in: 30 ... 60)
    
    @State private var travel = false
    @State private var hide = false
    
    var body: some View {
        GeometryReader { geometry in
            SunGlareShape()
                .fill(.white)
                .frame(width: glareWidth, height: glareWidth)
                .rotationEffect(.degrees(35), anchor: .top)
                .opacity(hide ? 0.07 : 0.01)
                .offset(x: ((travel ? 0 : glareTravelDistance) + glareDistanceAwayFromCorner) * 0.5,
                        y: ((travel ? 0 : glareTravelDistance) + glareDistanceAwayFromCorner) * 0.8)
                .task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: glareTravelDuration).repeatForever()) {
                            travel.toggle()
                        }
                        withAnimation(.easeInOut(duration: glareHideDuration).repeatForever()) {
                            hide.toggle()
                        }
                    }
                }
                .ignoresSafeArea()
        }
    }
}

struct SunGlareView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4288B6")
                .ignoresSafeArea()
            SunGlareView()
        }
    }
}

struct SunGlareShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.maxX * 0.5, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.25))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.75))
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * 0.75))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * 0.25))

        return path
    }
}
