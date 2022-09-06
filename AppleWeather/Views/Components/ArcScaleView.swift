//
//  ArcScaleView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 19/08/2022.
//

import SwiftUI

struct ArcScaleView: View {
    let value: Float
    let trailStart: Float
    let trailEnd: Float
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    let pathWidth = geometry.size.width - 10
                    let pathHeight = geometry.size.height - 10
                    
                    arcScalePath(width: pathWidth, height: pathHeight, arcScaleElement: .scale)
                        .stroke(Color(hex: "cfffff"), lineWidth: 1.5).opacity(0.5).blendMode(.lighten)
                    
                    arcScalePath(width: pathWidth, height: pathHeight, arcScaleElement: .trail, trailStart: trailStart, trailEnd: trailEnd)
                        .stroke(Color(hex: "cfffff"), lineWidth: 1.5).opacity(0.5).blendMode(.lighten)
                    
                    arcScalePath(width: pathWidth, height: pathHeight, arcScaleElement: .arrow, value: value)
                        .stroke(.white, lineWidth: 4)
                }
                .offset(x: 5, y: 5)
            }
            Color.clear
        }
    }
    
    enum ArcScaleElement {
        case scale
        case trail
        case arrow
    }
    
    func arcScalePath(width: CGFloat, height: CGFloat, arcScaleElement: ArcScaleElement, value: Float = 0, trailStart: Float = 0, trailEnd: Float = 0) -> Path {
        let centerX = CGFloat(width / 2)
        let centerY = CGFloat(height / 2)
        let lineLength = Float(9)
        var lineEnd = Float(centerX)
        var lineStart = lineEnd - Float(lineLength)
        
        let maxValue = Float(2.16)
        let start: Float
        let end: Float
        let step: Float
        
        switch arcScaleElement {
        case .scale:
            start = -maxValue
            end = maxValue
            step = Float(0.12)
        case .trail:
            start = maxValue * trailStart
            end = maxValue * trailEnd
            step = Float(0.001)
        case .arrow:
            start = maxValue * value
            end = maxValue * value
            step = Float(1)
            lineStart -= 3
            lineEnd += 3
        }
        
        let path = UIBezierPath()
        
        for angle in stride(from: start, through: end, by: step) {
            let sin = sin(Float(angle))
            let cos = cos(Float(angle))
            
            path.move(to: CGPoint(x: centerX + CGFloat(sin*lineStart),
                                  y: centerY - CGFloat(cos*lineStart)))
            path.addLine(to: CGPoint(x: centerX + CGFloat(sin*lineEnd),
                                     y: centerY - CGFloat(cos*lineEnd)))
        }
        
        return Path(path.cgPath)
    }
}

struct ArcScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            
            ArcScaleView(value: 0.2, trailStart: -0.1, trailEnd: 0.3)
        }
    }
}
