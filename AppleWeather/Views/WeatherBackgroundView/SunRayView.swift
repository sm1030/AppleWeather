//
//  SunRayView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 27/08/2022.
//

import SwiftUI

struct SunRayView: View {
    var beamWidth = Int.random(in: 30...60)
    var startAngle = Double.random(in: 0 ... 45)
    var endAngle = Double.random(in: 45 ... 90)
    var rotationDuration = Double.random(in: 30 ... 60)
    var hideDuration = Double.random(in: 10 ... 20)
    
    @State private var rotate = false
    @State private var hide = false
    
    var body: some View {
        GeometryReader { geometry in
            let beamLength = geometry.size.height * 1.2
            
            BeamShape()
                .fill(.white)
                .frame(width: CGFloat(beamWidth), height: beamLength)
                .rotationEffect(.degrees(rotate ? -startAngle : -endAngle), anchor: .topLeading)
                .opacity(hide ? 0.07 : 0.01)
                .task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: rotationDuration).repeatForever()) {
                            rotate.toggle()
                        }
                        withAnimation(.easeInOut(duration: hideDuration).repeatForever()) {
                            hide.toggle()
                        }
                    }
                }
                .ignoresSafeArea()
        }
    }
}

struct SunRayView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4288B6")
                .ignoresSafeArea()
            SunRayView()
        }
    }
}

//
//public extension UIImage {
//    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
//        let rect = CGRect(origin: .zero, size: size)
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
//        color.setFill()
//        UIRectFill(rect)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        guard let cgImage = image?.cgImage else { return nil }
//        self.init(cgImage: cgImage)
//    }
//}

struct BeamShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}
