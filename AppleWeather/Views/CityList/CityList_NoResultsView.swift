//
//  CityList_NoResultsView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 04/09/2022.
//

import SwiftUI

struct CityList_NoResultsView: View {
    
    @EnvironmentObject var cityListViewModel: CityListViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: UIFontMetrics.default.scaledValue(for: 54)))
                    .foregroundColor(Color(hex: "8D8E93"))
                    .padding(.bottom, 1)
                
                Text("No Results")
                    .font(.system(size: UIFontMetrics.default.scaledValue(for: 23)).weight(.bold))
                    .foregroundColor(.white)
                
                Text("No results found for \"\(cityListViewModel.searchText)\".")
                    .font(.system(size: UIFontMetrics.default.scaledValue(for: 17)))
                    .foregroundColor(Color(hex: "8D8E93"))
            }
        }
    }
}

struct CityList_NoResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let watherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
        CityList_NoResultsView()
            .environmentObject(watherViewModel.cityListViewModel)
    }
}
