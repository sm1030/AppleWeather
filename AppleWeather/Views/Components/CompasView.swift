//
//  CompasView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 18/08/2022.
//

import SwiftUI

struct CompasView: View {
    let arrowDirectionDegrees: Int
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    let pathWidth = geometry.size.width - 10
                    let pathHeight = geometry.size.height - 10
                    
                    compasPath(width: pathWidth, height: pathHeight, compasElement: .minorScale)
                        .stroke(Color(hex: "cfffff"), lineWidth: 0.5).opacity(0.5).blendMode(.lighten)
                    
                    compasPath(width: pathWidth, height: pathHeight, compasElement: .middleScale)
                        .stroke(Color(hex: "cfffff"), lineWidth: 1).opacity(0.5).blendMode(.lighten)
                    
                    compasPath(width: pathWidth, height: pathHeight, compasElement: .majorScale)
                        .stroke(Color(hex: "A9C2DC"), lineWidth: 2)
                    
                    compasPath(width: pathWidth, height: pathHeight, compasElement: .arrow, arrowDirectionDegrees: arrowDirectionDegrees)
                        .stroke(.white, lineWidth: 1.5)
                        
                }
                .offset(x: 5, y: 5)
            }
            Color.clear
        }
    }
    
    enum CompasElement {
        case minorScale
        case middleScale
        case majorScale
        case arrow
    }
    
    func compasPath(width: CGFloat, height: CGFloat, compasElement: CompasElement, arrowDirectionDegrees: Int = 0) -> Path {
        let stepDegree: CGFloat
        
        switch compasElement {
        case .minorScale:
            stepDegree = .pi / 84
        case .middleScale:
            stepDegree = .pi / 6
        case .majorScale:
            stepDegree = .pi / 2
        case .arrow:
            stepDegree = arrowDirectionDegrees > 0 ? CGFloat(arrowDirectionDegrees) / 360.0 * .pi*2 : .pi*2
        }
        
        let centerX = CGFloat(width / 2)
        let centerY = CGFloat(height / 2)
        let lineLength = Float(9)
        let lineEnd = Float(centerX)
        let lineStart = lineEnd - Float(lineLength)
        let arrowHandleLength = 27
        let arrowHandleStart = lineEnd - Float(arrowHandleLength)
        
        let path = UIBezierPath()
        
        for angle in stride(from: stepDegree, through: .pi*2, by: stepDegree) {
            let sin = sin(Float(angle))
            let cos = cos(Float(angle))
            
            if compasElement == .arrow {
                path.move(to: CGPoint(x: centerX + CGFloat(sin*arrowHandleStart),
                                      y: centerY - CGFloat(cos*arrowHandleStart)))
                path.addLine(to: CGPoint(x: centerX + CGFloat(sin*lineStart),
                                         y: centerY - CGFloat(cos*lineStart)))
                for m in stride(from: -1, through: 1, by: 0.5) {
                    path.move(to: CGPoint(x: centerX + CGFloat(sin*lineEnd),
                                             y: centerY - CGFloat(cos*lineEnd)))
                    path.addLine(to: CGPoint(x: centerX + CGFloat(sin*lineStart) + m * CGFloat(cos*lineLength)/2,
                                             y: centerY - CGFloat(cos*lineStart) + m * CGFloat(sin*lineLength)/2))
                }
                
                path.move(to: CGPoint(x: centerX - CGFloat(sin*arrowHandleStart),
                                      y: centerY + CGFloat(cos*arrowHandleStart)))
                path.addLine(to: CGPoint(x: centerX - CGFloat(sin*lineStart),
                                         y: centerY + CGFloat(cos*lineStart)))
                let ringCenterFromCompasCenterLength = lineStart + (lineLength / 2)
                let ringCenter = CGPoint(x: centerX - CGFloat(sin*ringCenterFromCompasCenterLength),
                                         y: centerY + CGFloat(cos*ringCenterFromCompasCenterLength))
                path.move(to: CGPoint(x: ringCenter.x + (CGFloat(lineLength) / 2),
                                      y: ringCenter.y))
                path.addArc(withCenter: ringCenter, radius: CGFloat(lineLength) / 2, startAngle: 0, endAngle: .pi*2, clockwise: true)
                return Path(path.cgPath)
            } else {
                path.move(to: CGPoint(x: centerX + CGFloat(sin*lineStart),
                                      y: centerY - CGFloat(cos*lineStart)))
                path.addLine(to: CGPoint(x: centerX + CGFloat(sin*lineEnd),
                                         y: centerY - CGFloat(cos*lineEnd)))
            }
        }
        
        if compasElement == .majorScale {
            for m in stride(from: -lineLength/2, through: lineLength/2, by: 0.5) {
                path.move(to: CGPoint(x: centerX, y: centerY - CGFloat(lineEnd)))
                path.addLine(to: CGPoint(x: centerX + CGFloat(m), y: centerY - CGFloat(lineStart)))
            }
        }
        
        return Path(path.cgPath)
    }
}

struct CompasView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            
            CompasView(arrowDirectionDegrees: 345)
        }
    }
}
