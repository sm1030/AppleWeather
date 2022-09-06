//
//  CityList_TopSlidingPanelView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 02/09/2022.
//

import SwiftUI

struct CityList_TopSlidingPanelView: View {
    
    @EnvironmentObject var cityListViewModel: CityListViewModel
    
    let staticPanelHeight: CGFloat
    let headerPanelScrollDistance: CGFloat

    @Binding var scrollViewContentOffset: CGFloat
    @Binding var searchText: String
    
    @FocusState var searchTextFieldIsFocused: Bool

    private var topSlidingPanelOffset: CGFloat {
        if searchTextFieldIsFocused {
            return -headerPanelScrollDistance - staticPanelHeight
        } else {
            if scrollViewContentOffset > headerPanelScrollDistance {
                return -headerPanelScrollDistance
            } else {
                return -scrollViewContentOffset
            }
        }
    }

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                // MARK: Movable "Weather" label
                HStack {
                    Text("Weather")
                        .font(.system(size: UIFontMetrics.default.scaledValue(for: 34)).weight(.bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, staticPanelHeight)
                .padding(.horizontal, 15)
                .padding(.bottom, -5)
                .opacity(searchTextFieldIsFocused ? 0 : (scrollViewContentOffset > headerPanelScrollDistance ? 0 : 1))
                
                // MARK: Search bar
                HStack(spacing: 0) {
                    HStack(spacing: 5) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hex: "8D8E93"))
                        TextField("", text: $searchText)
                            .submitLabel(.search)
                            .disableAutocorrection(true)
                            .focused($searchTextFieldIsFocused)
                            .disabled(cityListViewModel.editMode == .active)
                            .onChange(of: searchText, perform: { newValue in
                                cityListViewModel.searchTextHaveChabged(searchText: newValue)
                                cityListViewModel.updateSearchResultsDisplayMode()
                            })
                            .onChange(of: cityListViewModel.searchTextFieldIsFocused) {
                                searchTextFieldIsFocused = $0
                            }
                            .onChange(of: searchTextFieldIsFocused) {
                                cityListViewModel.searchTextFieldIsFocused = $0
                                cityListViewModel.updateSearchResultsDisplayMode()
                            }
                            .placeholder(when: searchText.isEmpty) {
                                Text("Search for a city or airport")
                                    .lineLimit(1)
                                    .foregroundColor(Color(hex: "8D8E93"))
                            }
                            .onChange(of: cityListViewModel.searchText) {
                                searchText = $0
                                cityListViewModel.updateSearchResultsDisplayMode()
                            }
                            .foregroundColor(Color(hex: "FFFFFF"))
                        
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(hex: "8D8E93"))
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, UIFontMetrics.default.scaledValue(for: 7))
                    .background(Color(hex: "1D1C1F"))
                    .cornerRadius(10)
                    
                    Button {
                        searchText = ""
                        searchTextFieldIsFocused.toggle()
                    } label: {
                        Text("Cancel")
                            .font(.callout)
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                    .padding(.trailing, searchTextFieldIsFocused ? 0 : -UIFontMetrics.default.scaledValue(for: 60))
                }
                .padding(.horizontal, 7)
                .padding(.vertical)
            }
            .background(.black)
            .offset(y: topSlidingPanelOffset)
            
            Spacer()
        }
        .animation(.linear(duration: 0.2), value: searchTextFieldIsFocused)
    }
}

struct CityList_TopSlidingPanelView_Previews: PreviewProvider {
    static var previews: some View {
        let watherViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false)
        CityList_TopSlidingPanelView(staticPanelHeight: 45,
                                        headerPanelScrollDistance: 0,
                                        scrollViewContentOffset: .constant(0),
                                        searchText: .constant(""))
        .environmentObject(watherViewModel.cityListViewModel)
    }
}
