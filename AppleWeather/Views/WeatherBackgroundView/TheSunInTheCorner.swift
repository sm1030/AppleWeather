//
//  TheSunInTheCorner.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 28/08/2022.
//

import SwiftUI

struct TheSunInTheCorner: View {
    let sunRadius = CGFloat(200)
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(
                    RadialGradient(gradient: Gradient(colors:
                                                        [.white.opacity(0.7),
                                                         .white.opacity(0.3),
                                                         .white.opacity(0.1),
                                                         .white.opacity(0.03),
                                                         .white.opacity(0)]),
                                   center: .center, startRadius: 0, endRadius: sunRadius)
                )
                .frame(width: sunRadius*2, height: sunRadius*2, alignment: .topLeading)
                .offset(x: -sunRadius, y: -sunRadius)
                .ignoresSafeArea()
        }
    }
}

struct TheSunInTheCorner_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4288B6")
                .ignoresSafeArea()
            TheSunInTheCorner()
        }
    }
}
