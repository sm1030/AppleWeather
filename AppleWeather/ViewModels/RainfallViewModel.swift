//
//  RainfallViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 18/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class RainfallViewModel: TwoLinesMessageViewModel {

    func publish(_ locationModel: LocationModel) {
        var topMessage = self.topMessage
        var bottomMessage = self.bottomMessage
        
        if let today = locationModel.location.days.first {
            topMessage = "\(Int(today.precip)) mm\nin last 24 hours"
        }
        
        if locationModel.location.days.count > 1 {
            let tomorrow = locationModel.location.days[1]
            bottomMessage = "\(Int(tomorrow.precip)) mm expec- ted in next 24h."
        }
        
        if self.topMessage != topMessage {
            self.topMessage = topMessage
        }
        if self.bottomMessage != bottomMessage {
            self.bottomMessage = bottomMessage
        }
    }
}

