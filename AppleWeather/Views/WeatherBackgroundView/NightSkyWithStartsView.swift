//
//  NightSkyWithStartsView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 30/08/2022.
//

import SwiftUI

struct NightSkyWithStartsView: View {
    
    var body: some View {
        GeometryReader { geometry in
            Image("night-sky-with-stars")
                .resizable()
                .scaledToFit()
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear, .clear]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
        }
    }
}

struct NightSkyWithStartsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4288B6")
                .ignoresSafeArea()
            NightSkyWithStartsView()
        }
    }
}
