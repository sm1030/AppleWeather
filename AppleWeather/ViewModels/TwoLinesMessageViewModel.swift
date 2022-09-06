//
//  TwoLinesMessageViewModel.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 29/08/2022.
//

import SwiftUI
import Foundation

@MainActor class TwoLinesMessageViewModel: ObservableObject {

    @Published var topMessage = ""
    @Published var bottomMessage = ""
}

