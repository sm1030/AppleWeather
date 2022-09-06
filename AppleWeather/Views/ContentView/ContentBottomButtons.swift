//
//  ContentBottomButtons.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 07/08/2022.
//

import SwiftUI

struct ContentBottomButtons: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @State var isShowingMap = false
    @State var isShowingCityList = false
    
    var body: some View {
        // MARK: Content bottom buttons
        VStack {
            Spacer()
            HStack {
                Button {
                    isShowingMap.toggle()
                } label: {
                    Image(systemName: "map")
                        .font(.title2.weight(.light))
                        .foregroundColor(.white)
                }
                .fullScreenCover(isPresented: $isShowingMap) {
                    if let mapViewModel = weatherViewModel.selectedLocationViewModel.mapViewModel {
                        MapView()
                            .environmentObject(mapViewModel)
                    }
                }
                
                Spacer()
                
                Button {
                    isShowingCityList.toggle()
                } label: {
                    Image(systemName: "list.star")
                        .font(.title2.weight(.light))
                        .foregroundColor(.white)
                }
                .fullScreenCover(isPresented: $isShowingCityList) {
                    CityListView()
                        .environmentObject(weatherViewModel)
                        .environmentObject(weatherViewModel.cityListViewModel)
                }
            }
            .frame(height: 30)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 10)
        }
    }
}

struct ContentBottomButtons_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color(hex: "6CA1C8"))
                    .frame(height: 50)
            }
            ContentBottomButtons()
        }
    }
}
