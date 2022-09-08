//
//  CityListView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 01/09/2022.
//

import SwiftUI

struct CityListView: View {
    
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @EnvironmentObject var cityListViewModel: CityListViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var scrollViewLastContentOffset = CGFloat(0)
    @State private var searchText: String = ""
    
    let staticPanelHeight: CGFloat = 44
    let searchBarHeight = UIFontMetrics.default.scaledValue(for: 28)
    let headerPanelScrollDistance = UIFontMetrics.default.scaledValue(for: 34)
    
    private var firstScrollablePlaceholderItemHeight: CGFloat {
        if cityListViewModel.searchTextFieldIsFocused {
            return searchBarHeight + 32
        } else {
            return staticPanelHeight + headerPanelScrollDistance + searchBarHeight + 38
        }
    }
    
    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
    }
    
    private func onDelete(offsets: IndexSet) {
        cityListViewModel.deleteCity(offsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        cityListViewModel.moveCity(source: source, destination: destination)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(.black)
                    .ignoresSafeArea()
                
                GeometryReader { outsideProxy in
                    List {
                        GeometryReader { insideProxy in
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
                        }
                        .frame(height: firstScrollablePlaceholderItemHeight)
                        .listRowBackground(Color.black)

                        ForEach(weatherViewModel.locationViewModels) { locationViewModel in
                            Button {
                                weatherViewModel.selectTabWithLocation(locationViewModel)
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                CityList_ItemView()
                                    .environmentObject(locationViewModel)
                            }
                        }
                        .onDelete(perform: onDelete)
                        .onMove(perform: onMove)
                    }
                    .environment(\.editMode, $cityListViewModel.editMode)
                    .listStyle(.plain)
                    .background(.black)
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        let offset = value.reduce(0, +)
                        if scrollViewLastContentOffset > 50 && offset == 0 {
                            scrollViewContentOffset = scrollViewLastContentOffset
                        } else {
                            scrollViewLastContentOffset = offset
                            scrollViewContentOffset = offset
                        }
                    }
                }
                
                if cityListViewModel.searchResultsDisplayMode == .solidBackground {
                    Button {
                        cityListViewModel.searchTextFieldIsFocused.toggle()
                    } label: {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                    }
                }

                if cityListViewModel.searchResultsDisplayMode == .noResultsFound {
                    CityList_NoResultsView()
                        .environmentObject(cityListViewModel)
                }

                if cityListViewModel.searchResultsDisplayMode == .showSearchResults {
                    CityList_SearchResultsView(firstScrollablePlaceholderItemHeight: firstScrollablePlaceholderItemHeight)
                }

                CityList_TopSlidingPanelView(staticPanelHeight: staticPanelHeight,
                                                headerPanelScrollDistance: headerPanelScrollDistance,
                                                scrollViewContentOffset: $scrollViewContentOffset,
                                                searchText: $searchText)
                .environmentObject(cityListViewModel)

                CityList_TopStaticPanelView(staticPanelHeight: staticPanelHeight,
                                               headerPanelScrollDistance: headerPanelScrollDistance,
                                               scrollViewContentOffset: $scrollViewContentOffset)
                .environmentObject(cityListViewModel)
            }
            .animation(.linear(duration: 0.2), value: cityListViewModel.searchTextFieldIsFocused)
            .animation(.linear(duration: 0.2), value: cityListViewModel.editMode)
            .alert(cityListViewModel.alertMessage, isPresented: $cityListViewModel.isShowingAlert) {
                Button("OK", role: .cancel) { }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
        CityListView()
            .environmentObject(weatherViewModel)
            .environmentObject(weatherViewModel.cityListViewModel)
    }
}
