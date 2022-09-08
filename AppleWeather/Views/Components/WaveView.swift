//
//  WaveView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 17/08/2022.
//

import SwiftUI

struct WaveView: View {
    let sunriseInSeconds: Int
    let sunsetInSeconds: Int
    let sunPositionInSeconds: Int
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    let isDay = sunPositionInSeconds > sunriseInSeconds && sunPositionInSeconds < sunsetInSeconds
                    let pathWidth = geometry.size.width - 10
                    let pathHeight = geometry.size.height - 10
                    let topLineGradientColors = [Color(hex: "A3C7E0"),
                                                 Color(hex: "73A8CF"),
                                                 Color(hex: "73A8CF")]
                    let topLineGradient = LinearGradient(gradient: Gradient(colors: topLineGradientColors), startPoint: .top, endPoint: .bottom)
                    wavePath(width: pathWidth, height: pathHeight, pathElement: .day, sunriseInSeconds: sunriseInSeconds, sunsetInSeconds: sunsetInSeconds, sunPositionInSeconds: sunPositionInSeconds)
                        .stroke(topLineGradient, lineWidth: 5)
                    
                    wavePath(width: pathWidth, height: pathHeight,  pathElement: .night, sunriseInSeconds: sunriseInSeconds, sunsetInSeconds: sunsetInSeconds, sunPositionInSeconds: sunPositionInSeconds)
                        .stroke(Color(hex: "3E7099"), lineWidth: 5)
                    
                    wavePath(width: pathWidth, height: pathHeight, pathElement: .horizont, sunriseInSeconds: sunriseInSeconds, sunsetInSeconds: sunsetInSeconds, sunPositionInSeconds: sunPositionInSeconds)
                        .stroke(Color(hex: "98AFC6"), lineWidth: 2)
                    
                    wavePath(width: pathWidth, height: pathHeight, pathElement: .sun, sunriseInSeconds: sunriseInSeconds, sunsetInSeconds: sunsetInSeconds, sunPositionInSeconds: sunPositionInSeconds)
                        .stroke(.white, lineWidth: isDay ? 5 : 1)
                }
                .offset(x: 5, y: 5)
            }
            Color.clear
        }
    }
    
    enum PathElement {
        case day
        case night
        case sun
        case horizont
    }
    
    func wavePath(width: CGFloat, height: CGFloat, pathElement: PathElement, sunriseInSeconds: Int, sunsetInSeconds: Int, sunPositionInSeconds: Int) -> Path {
        
        let noonInSeconds = sunriseInSeconds + (sunsetInSeconds-sunriseInSeconds)/2
        let secondsInDay = 24 * 3600
        let prefectNoon = secondsInDay / 2
        let ofsetInSeconds = noonInSeconds - prefectNoon
        let ofsettedSunriseInSeconds = Int((sunriseInSeconds - ofsetInSeconds) / 100) * 100
        let ofsettedSunsetInSeconds = Int((sunsetInSeconds - ofsetInSeconds) / 100) * 100
        var offsettedSunPosition = Int((sunPositionInSeconds - ofsetInSeconds) / 100) * 100
        if offsettedSunPosition < 0 {
            offsettedSunPosition = 0
        }
        
        let path = UIBezierPath()
        
        var isDrawing = false

        for second in stride(from: 0, through: secondsInDay, by: 100) {
            let sine = sin(Float(second) / Float(secondsInDay) * .pi*2 + .pi*0.5) // .pi*0.5, through: .pi*2.5
            
            let y = CGFloat(sine) * height/2 + height/2
            let x = CGFloat(second) / CGFloat(secondsInDay) * width
            
            let isDay = second > ofsettedSunriseInSeconds && second < ofsettedSunsetInSeconds
            
            switch pathElement {
            case .day:
                if isDay && isDrawing == false {
                    path.move(to: CGPoint(x: x, y: y))
                    isDrawing = true
                }
                if !isDay && isDrawing {
                    isDrawing = false
                }
            case .night:
                if !isDay && isDrawing == false {
                    path.move(to: CGPoint(x: x, y: y))
                    isDrawing = true
                }
                if isDay && isDrawing == true {
                    isDrawing = false
                }
            case .sun:
                if second == offsettedSunPosition {
                    if isDay {
                        path.move(to: CGPoint(x: x+3, y: y))
                        path.addArc(withCenter: CGPoint(x: x, y: y), radius: 3, startAngle: 0, endAngle: .pi*2, clockwise: true)
                    } else {
                        path.move(to: CGPoint(x: x+6, y: y))
                        path.addArc(withCenter: CGPoint(x: x, y: y), radius: 6, startAngle: 0, endAngle: .pi*2, clockwise: true)
                    }
                }
            case .horizont:
                if second == ofsettedSunriseInSeconds {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
            }

            if isDrawing {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return Path(path.cgPath)
    }
}

struct WaveView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            let uvIndexViewModel = weatherViewModel.selectedLocationViewModel.uvIndexViewModel
            WaveView(sunriseInSeconds: 5*3600 + 49*60,
                     sunsetInSeconds: 20*3600 + 21*60,
                     sunPositionInSeconds: 11*3600)
                .environmentObject(uvIndexViewModel)
        }
    }
}
