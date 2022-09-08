//
//  TwoLineMessageView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 18/08/2022.
//

import SwiftUI

struct TwoLineMessageView: View {
    @EnvironmentObject var model: TwoLinesMessageViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.topMessage)
                .font(.title2)
                .foregroundColor(.white)
            Text(model.bottomMessage)
                .font(.footnote)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct TwoLineMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4082BE")
                .ignoresSafeArea()
            let weatherViewModel = WeatherViewModel(isUsingMockData: true, asyncMode: false)
            let feelsLikeViewModel = weatherViewModel.selectedLocationViewModel.feelsLikeViewModel
            TwoLineMessageView()
                .environmentObject(feelsLikeViewModel as TwoLinesMessageViewModel)
        }
    }
}
