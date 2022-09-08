//
//  CityList_SearchResults.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 03/09/2022.
//

import SwiftUI

struct CityList_SearchResultsView: View {
    
    @State var firstScrollablePlaceholderItemHeight: CGFloat
    @State private var isShowingLocationPreview = false
    
    @EnvironmentObject var cityListViewModel: CityListViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView() {
                VStack(spacing: 0) {
                    Color.clear
                        .frame(height: firstScrollablePlaceholderItemHeight)
                    
                    ForEach(cityListViewModel.searchResults) {autocomplete in
                        let totalString = autocomplete.displayName
                        let highlightedText = totalString.prefix(cityListViewModel.searchTextLengh)
                        let theRestOfTheString = totalString.dropFirst(cityListViewModel.searchTextLengh)
                        
                        Button {
                            cityListViewModel.previewLocation(with: autocomplete.vcwAddress)
                            cityListViewModel.searchTextFieldIsFocused = false
                            isShowingLocationPreview.toggle()
                        } label: {
                            HStack {
                                Text(highlightedText).foregroundColor(.white)+Text(theRestOfTheString)
                                    .foregroundColor(Color(hex: "949499"))
                                
                                Spacer()
                            }
                            .sheet(isPresented: $isShowingLocationPreview) {
                                CityList_LocationPreview()
                                    .environmentObject(cityListViewModel)
                                
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct CityList_SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let watherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
        let cityListViewModel = watherViewModel.cityListViewModel
        CityList_SearchResultsView(firstScrollablePlaceholderItemHeight: 100)
            .environmentObject(cityListViewModel)
            .onAppear {
                cityListViewModel.searchTextLengh = 2
                cityListViewModel.searchResults = [
                    City(geonameid: 1, name: "London", country: "United Kingdom ", subcountry: "England"),
                    City(geonameid: 2, name: "Paris", country: "France ", subcountry: "cele-de-France"),
                    City(geonameid: 3, name: "Sydney", country: "Australia ", subcountry: "New South Wales")
                ]
            }
    }
}
