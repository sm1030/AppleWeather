//
//  TemperatureView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 22/08/2022.
//

import SwiftUI
import MapKit

struct TemperatureView: View {

    @EnvironmentObject var model: TemperatureViewModel
    
    @State private var showingTemperatureDetailsSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Button {
                    showingTemperatureDetailsSheet = true
                } label: {
                    Map(coordinateRegion: $model.mapRegion)
                }
                
                Rectangle()
                    .fill(Color(temperature: Float(model.temperature)))
                    .opacity(0.5)
            }
            .cornerRadius(7)
            .padding(.horizontal, 5)
            .padding(.vertical, 5)
            .frame(height: 200)
            
            Button {
                showingTemperatureDetailsSheet = true
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
        .fullScreenCover(isPresented: $showingTemperatureDetailsSheet) {
            if let mapViewModel = model.locationViewModel?.mapViewModel {
                MapView()
                    .environmentObject(mapViewModel)
            }
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
            let temperatureViewModel = weatherViewModel.selectedLocationViewModel.temperatureViewModel
            TemperatureView()
                .environmentObject(temperatureViewModel)
        }
    }
}
