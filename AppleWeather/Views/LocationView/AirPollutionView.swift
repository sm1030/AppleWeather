//
//  AirPollutionView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 20/08/2022.
//

import SwiftUI

struct AirPollutionView: View {
    
    @EnvironmentObject var model: AirPollutionViewModel
    
    @State private var isShowingAirPollutionDetailsSheet = false
    
    let polutionColors = [Color(hex: "65DB7C"),
                          Color(hex: "65DA7C"),
                          Color(hex: "65DA7B"),
                          Color(hex: "6ACA66"),
                          Color(hex: "7CBE56"),
                          Color(hex: "A4B145"),
                          Color(hex: "CDA33A"),
                          Color(hex: "F09938"),
                          Color(hex: "EC7B35"),
                          Color(hex: "EA6439"),
                          Color(hex: "E8523E"),
                          Color(hex: "E64048"),
                          Color(hex: "E43656"),
                          Color(hex: "C62C96"),
                          Color(hex: "AA23D5")]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.topMessage)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, -5)
            
            Text(model.message)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.bottom, 7)
            
            ScaleView(colors: polutionColors, value: scaleValue(polutionValue: model.value))
            
            Color(hex: "cfffff").opacity(0.5).blendMode(.lighten)
                .frame(height: 1)
                .padding(.top, 18)
            
            Button {
                isShowingAirPollutionDetailsSheet.toggle()
            } label: {
                HStack {
                    Text("See More")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(Color.greyBlue)
                }
            }
            .padding(.bottom, 5)
        }
        .padding(.horizontal)
        .sheet(isPresented: $isShowingAirPollutionDetailsSheet) {
            AirPolutionDetailsView()
        }
    }
    
    func scaleValue(polutionValue: Int) -> Float {
        let value = Float(polutionValue / 10) + 0.1
        if value > 1 {
            return 1
        } else {
            return value
        }
    }
}

struct AirPolutionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            let airPollutionViewModel = weatherViewModel.selectedLocationViewModel.airPollutionViewModel
            AirPollutionView()
                .environmentObject(airPollutionViewModel)
        }
    }
}
