//
//  CityList_TopStaticPanelView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 02/09/2022.
//

import SwiftUI

struct CityList_TopStaticPanelView: View {
    
    @EnvironmentObject var cityListViewModel: CityListViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var staticPanelHeight: CGFloat
    @State var headerPanelScrollDistance: CGFloat
    
    @Binding var scrollViewContentOffset: CGFloat
    
    private var staticWeatherTextOpacity: CGFloat {
        scrollViewContentOffset > headerPanelScrollDistance ? 1 : 0
    }
    
    var body: some View {
        ZStack {
            VStack {
                Color.black
                    .frame(height: staticPanelHeight)
                    .overlay {
                        
                        // MARK: Static "Weather" label at the top
                        Text("Weather")
                            .font(.body).fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(alignment: .top)
                            .opacity(staticWeatherTextOpacity)
                    }
                    .overlay {
                        HStack {
                            Spacer()
                            
                            // MARK: Menu button
                            if cityListViewModel.editMode != .active {
                                Button {
                                    cityListViewModel.editMode = .active
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                            } else {
                                Button {
                                    cityListViewModel.editMode = .inactive
                                } label: {
                                    Text("Done")
                                        .font(.body)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.trailing)
                    }
                Spacer()
            }
            .opacity(cityListViewModel.searchTextFieldIsFocused ? 0 : 1)
        }
        .animation(.linear(duration: 0.2), value: cityListViewModel.searchTextFieldIsFocused)
        .onAppear {
            UITextField.appearance().keyboardAppearance = .dark
        }
    }
}

struct CityList_TopStaticPanelView_Previews: PreviewProvider {
    static var previews: some View {
        let cityListViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false).cityListViewModel
        CityList_TopStaticPanelView(staticPanelHeight: 45,
                                       headerPanelScrollDistance: 0,
                                       scrollViewContentOffset: .constant(0))
        .environmentObject(cityListViewModel)
    }
}

