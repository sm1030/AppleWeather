//
//  StickyHeaderScrollBacground.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 11/08/2022.
//

import SwiftUI

struct StickyHeaderScrollPanelBackground: ViewModifier {
    
    let titleText: String
    let titleSFSymbol: String?
    let alternativeTitleText: String?
    let headerHight: CGFloat = 40
    let bottonContentInset: CGFloat = 10
    
    private func backgroundWidth(_ geometry: GeometryProxy) -> CGFloat {
        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
        return geometryFrame.size.width
    }
    
    private func backgroundHeight(_ geometry: GeometryProxy) -> CGFloat {
        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
        if geometryFrame.origin.y > 0 {
            return geometryFrame.size.height
        } else {
            let height = geometryFrame.size.height + geometryFrame.origin.y
            if height > headerHight {
                return height
            } else {
                return headerHight
            }
        }
    }
    
    private func backgroundOffset(_ geometry: GeometryProxy) -> CGFloat {
        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
        if geometryFrame.origin.y > 0 {
            return 0
        } else {
            return -geometryFrame.origin.y
        }
    }
    
    private func contentHeigh(_ geometry: GeometryProxy) -> CGFloat {
        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
        return geometryFrame.height - headerHight
    }
    
    private func contentOffset(_ geometry: GeometryProxy) -> CGFloat {
        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
        if geometryFrame.origin.y > 0 {
            return 0 - bottonContentInset / 2
        } else {
            return geometryFrame.origin.y / 2 - bottonContentInset / 2
        }
    }
    
    private func headerOpacity(_ geometry: GeometryProxy) -> CGFloat {
        if alternativeTitleText != nil {
            let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
            if geometryFrame.origin.y  > -5 {
                return 0
            } else if geometryFrame.origin.y > -10 {
                return (geometryFrame.origin.y + 5) / -5
            } else {
                return contentOpacity(geometry)
            }
        } else {
            return contentOpacity(geometry)
        }
    }
    
    private func alternativeTitleOpacity(_ geometry: GeometryProxy) -> CGFloat {
        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
        if geometryFrame.origin.y  > 0 {
            return 1
        } else if geometryFrame.origin.y > -5 {
            return (geometryFrame.origin.y + 5) / 5
        } else {
            return 0
        }
    }
    
    private func contentOpacity(_ geometry: GeometryProxy) -> CGFloat {
        let geometryFrame = geometry.frame( in: .named("LocationScrollView"))
        let height = geometryFrame.size.height + geometryFrame.origin.y
        if height > headerHight {
            return 1
        } else if height>0 {
            return height / headerHight
        } else {
            return 0
        }
    }
    
    func body(content: Content) -> some View {
        // BEST so far: .fill(Color(hex: "30647F")!).opacity(0.5).blendMode(.hardLight) // Problem - White is blue
        ZStack {
            Color.clear
                .overlay {
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 15)
//                            .fill(Color(hex: "30647F")).opacity(0.5).blendMode(.hardLight) // White is blue
                            .fill(Color(hex: "60646F")).opacity(0.5).blendMode(.hardLight) // Bit darker blue but without bluish white
//                            .fill(Color(hex: "AFDFFF")).opacity(0.5).blendMode(.plusDarker) // White is less blue
//                            .fill(Color(hex: "444444")).opacity(0.5).blendMode(.luminosity) // Darker, but works for night colors
//                            .fill(Color(hex: "000000")).opacity(0.5).blendMode(.color) // 3C83BB
//                            .fill(Color(hex: "cfffff")).opacity(0.5).blendMode(.lighten) // 7BC7F9
                            .frame(width: backgroundWidth(geometry), height: backgroundHeight(geometry))
                            .offset(y: backgroundOffset(geometry))
                            .opacity(contentOpacity(geometry))

                        if let alternativeTitleText = alternativeTitleText {
                            Text(alternativeTitleText)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .font(.footnote)
                                .offset(y: backgroundOffset(geometry) + 10)
                                .opacity(alternativeTitleOpacity(geometry))
                        }

                        HStack {
                            if let titleSFSymbol = titleSFSymbol, !titleSFSymbol.isEmpty {
                                Image(systemName: titleSFSymbol)
                                    .font(.caption)
                                    .foregroundColor(Color(hex: "cfffff")).opacity(0.5).blendMode(.lighten)
                            }
                            Text(titleText)
                                .font(.caption)
                                .foregroundColor(Color(hex: "cfffff")).opacity(0.5).blendMode(.lighten)
                        }
                        .offset(x: 16, y: backgroundOffset(geometry) + 11)
                        .opacity(headerOpacity(geometry))
                        
                        Color.clear
                            .overlay {
                                content
                                    .frame(width: backgroundWidth(geometry), height: contentHeigh(geometry))
                                    .offset(y: contentOffset(geometry))
                            }
                            .clipped()
                            .frame(width: backgroundWidth(geometry), height: backgroundHeight(geometry) - headerHight)
                            .offset(y: backgroundOffset(geometry) + headerHight)
                            .opacity(contentOpacity(geometry))
                    }
                }
            
            if let alternativeTitleText = alternativeTitleText {
                VStack {
                    Text(alternativeTitleText)
                        .opacity(0)
                        .font(.footnote)
                        .padding(.horizontal)
                        .padding(.bottom)
                    content
                        .opacity(0)
                        .padding(.bottom, bottonContentInset)
                }
            } else {
                content
                    .padding(.top, headerHight)
                    .opacity(0)
                    .padding(.bottom, bottonContentInset)
            }
        }
        .padding(.bottom, 3)
    }
}

extension View {
    func stickyHeaderScrollBacground(titleText: String, titleSFSymbol: String?, alternativeTitleText: String? = nil) -> some View {
        modifier(StickyHeaderScrollPanelBackground(titleText: titleText, titleSFSymbol: titleSFSymbol, alternativeTitleText: alternativeTitleText))
    }
}

struct StickyHeaderScrollBacground_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                // Night UP background colors
                Color(hex: "1C1F33") // 28 31 51
                Color(hex: "1C213D") // 28 33 61
                
                // Night UP background colors
                Color(hex: "2E344F") // 46 52 79
                Color(hex: "2A3254") // 42 50 84    #263059 // 38 48 89
                
                // Day background colors
                Color(hex: "5392BB") // 83 146 187
                Color(hex: "3C83BB") // 60 131 187   #1975BB // 25 117 187  Correct: #2574BB // 37 116 187
                
                // Day title font color
                Color(hex: "5392BB") // 83 146 187
                Color(hex: "7BC7F9") // 60 131 187   #1975BB // 25 117 187  Correct: #2574BB // 37 116 187
            }
            .frame(height: 200)
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            let hourlyForecastViewModel = weatherViewModel.selectedLocationViewModel.hourlyForecastViewModel
            HourlyForecastView()
                .environmentObject(hourlyForecastViewModel)
                .stickyHeaderScrollBacground(titleText: "10-DAY FORECAST",
                                             titleSFSymbol: "calendar",
                                             alternativeTitleText: nil)
        }
        .background(Color(hex: "5392BB")) // FFFFFF 888888
    }
}
