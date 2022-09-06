//
//  TemperatureMapView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 22/08/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var model: MapViewModel
    
    @State private var isShowingMapLocationSheetView = false
    
    var body: some View {
        ZStack(alignment: .center) {
            
            // MARK: The map
            Map(coordinateRegion: $model.mapRegion)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Temperature color over map
            Color(temperature: Float(model.temperature))
                .opacity(0.5)
                .allowsHitTesting(false)
            
            // MARK: Status bar background
            VStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: getSafeAreaTop())
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            
            HStack {
                
                // MARK: Left side buttons
                VStack(alignment: .leading, spacing: 7) {
                    Button() {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.regularMaterial)
                            Text("Done")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .frame(width: 70, height: 42, alignment: .topLeading)
                    }
                    
                    VStack(alignment: .leading, spacing: 0.5) {
                        Text("Temperature")
                            .font(.caption).fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 12)
                            .background(RoundedCorners(tl: 10, tr: 10, bl: 0, br: 0).fill(.thinMaterial))
                        
                        MapTemperatureLegentView()
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                // MARK: Right side buttons
                VStack(alignment: .leading, spacing: 0.5) {
                    Button() {
                        model.moveToUserLocation()
                    } label: {
                        Image(systemName: "location")
                            .font(.system(size: 22, weight: .light))
                            .foregroundColor(.black)
                            .padding(10)
                            .background(RoundedCorners(tl: 10, tr: 10, bl: 0, br: 0).fill(.regularMaterial))
                    }
                    
                    Button() {
                        isShowingMapLocationSheetView.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 22, weight: .light))
                            .foregroundColor(.black)
                            .padding(10)
                            .background(RoundedCorners(tl: 0, tr: 0, bl: 10, br: 10).fill(.regularMaterial))
                    }
                    
                    Spacer()
                }
            }
            .padding(8)
            
            // MARK: Central temperature badge
            MapTemperatureBadgeView()
                .environmentObject(model)
                .offset(y: -25)
        }
        .onAppear {
            model.moveToLocationLocation()
        }
        .sheet(isPresented: $isShowingMapLocationSheetView) {
            MapLocationsSheetView(mockLocations: nil)
        }
    }
    
    func getSafeAreaTop() -> CGFloat{
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return (keyWindow?.safeAreaInsets.top)!
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let mapViewModel = WeatherViewModel(isUsingMockData: true, assyncMode: false).selectedLocationViewModel.mapViewModel
            MapView()
                .environmentObject(mapViewModel)
        }
    }
}
