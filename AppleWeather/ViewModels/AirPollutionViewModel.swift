//
//  AirPollutionViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 20/08/2022.
//

import SwiftUI
import Foundation

@MainActor final class AirPollutionViewModel: ObservableObject {

    @Published var topMessage = ""
    @Published var message = ""
    @Published var value: Int = 0

    func publish(_ locationModel: LocationModel) {
        let topMessage = "2 - Low"
        let message = "Air quality index is 2, which is similar to yesterday at about this time."
        let value = 2
        
        if self.topMessage != topMessage {
            self.topMessage = topMessage
        }
        if self.message != message {
            self.message = message
        }
        if self.value != value {
            self.value = value
        }
    }
}
