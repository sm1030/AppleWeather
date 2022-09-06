//
//  AirPolutionDetailsView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 21/08/2022.
//

import SwiftUI

struct AirPolutionDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var scrollViewContentOffset = CGFloat(0)
    
    private func headerBackgroundOpacity() -> CGFloat {
        if scrollViewContentOffset  < 0 {
            return 0
        } else if scrollViewContentOffset < 10 {
            return scrollViewContentOffset / 10
        } else {
            return 1
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "2C2D2E"))
            
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {
                AirPolutionDetailsPanelView(title: "Low",
                                            subtitle: "Scale: United Kingdom (DAQI)",
                                            message: "Air quality index is 2, which is similar to yesterday at about this time.",
                                            airQualityValue: 0.1)
                    .padding(.top, 70)
                
                AirPolutionDetailsPanelView(title: "Health Information",
                                            subtitle: nil,
                                            message: "Enjoy your usual outdoor activities.",
                                            airQualityValue: nil)
                
                AirPolutionDetailsPanelView(title: "Primary Pollutant",
                                            subtitle: "Ozone (O₃)",
                                            message: "Ozone is typically elevated due to traffic, fossil fuel combustion and fires, and can be transported long distances.",
                                            airQualityValue: nil)
                
                HStack {
                    Text("Air Quality data provided by ").foregroundColor(Color(hex: "9B9BA2")).font(.footnote) + Text("[BreezoMeter](https://www.breezometer.com/air-quality-map/air-quality/united-kingdom/london)").font(.footnote).underline()
                    
                    Spacer()
                }
                .padding()
                .padding(.top, -31)
                .accentColor(Color(hex: "9B9BA2"))
                
            }
            
            VStack {
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color(hex: "373737"))
                        Rectangle()
                            .fill(Color(hex: "494A4C"))
                            .frame(height: 1)
                    }
                    .opacity(headerBackgroundOpacity())
                    
                    HStack {
                        Image(systemName: "aqi.low")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Air Pollution")
                            .font(.system(size: UIFontMetrics.default.scaledValue(for: 17)).weight(.semibold))
                            .foregroundColor(.white)
                    }
                    HStack {
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 29, weight: .light))
                                .foregroundStyle(Color(hex: "A8A8AE"), .green, Color(hex: "414244"))
                                .padding(.trailing)
                        }

                    }
                }
                .frame(height: 55)
                Spacer()
            }
        }
    }
}

struct AirPolutionDetailsPanelView: View {
    let title: String
    let subtitle: String?
    let message: String
    let airQualityValue: Float?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: UIFontMetrics.default.scaledValue(for: 20)).weight(.bold))
                .foregroundColor(.white)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.callout)
                    .foregroundColor(Color(hex: "9B9BA2"))
                    .padding(.top, -8)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "39393C"))
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(message)
                            .font(.body)
                            .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                    
                    if let airQualityValue = airQualityValue {
                        ScaleView(colors: Color.airPollutionColors, value: airQualityValue)
                    }
                }
                .padding()
            }
            .padding(.top, -2)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct AirPolutionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AirPolutionDetailsView()
    }
}
