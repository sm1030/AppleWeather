//
//  ScaleView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 16/08/2022.
//

import SwiftUI

struct ScaleView: View {
    let colors: [Color]
    let value: Float?
    
    var body: some View {
        ZStack {
            Color.clear
                .overlay {
                    GeometryReader { geometry in
                        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
                        
                        Color.clear
                            .overlay {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill( LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
                                    .frame(height: 4)
                                    .offset(x: 0,
                                            y: geometryFrame.height / 2)
                            }
                        
                        if let value = value {
                            Color.clear
                                .overlay{
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(width: 8, height: 4)
                                        .background(Color(hex: "417098"))

                                    Circle()
                                        .fill(.white)
                                        .frame(height: 4)
                                }
                                .frame(width: 8, height: 4)
                                .offset(x: geometryFrame.width * CGFloat(value),
                                        y: geometryFrame.height / 2)
                        }
                    }
                }.frame(height: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .opacity(0)
                    .frame(height: 4)
                    .coordinateSpace(name: "PolutionScale")
            }
        }
    }
}

struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
            
            let uvColors = [Color(hex: "6ACD65"),
                            Color(hex: "B7D24D"),
                            Color(hex: "F7D54A"),
                            Color(hex: "F3B741"),
                            Color(hex: "F09C3B"),
                            Color(hex: "ED6C48"),
                            Color(hex: "E24C76"),
                            Color(hex: "B45FE6")]
//            let polutionColors = [Color(hex: "65DB7C"),
//                                  Color(hex: "65DA7C"),
//                                  Color(hex: "65DA7B"),
//                                  Color(hex: "6ACA66"),
//                                  Color(hex: "7CBE56"),
//                                  Color(hex: "A4B145"),
//                                  Color(hex: "CDA33A"),
//                                  Color(hex: "F09938"),
//                                  Color(hex: "EC7B35"),
//                                  Color(hex: "EA6439"),
//                                  Color(hex: "E8523E"),
//                                  Color(hex: "E64048"),
//                                  Color(hex: "E43656"),
//                                  Color(hex: "C62C96"),
//                                  Color(hex: "AA23D5")]
            ScaleView(colors: uvColors, value: 0.1)
        }
    }
}
