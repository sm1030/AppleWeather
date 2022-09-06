//
//  TemperatureView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 12/08/2022.
//

import SwiftUI

struct TemperatureColorView: View {
    
    var body: some View {
        ScrollView {
            ForEach((-40...50).reversed(), id: \.self) {temp in
                ZStack {
                    Color(temperature: Float(temp))
                    Text("\(temp)°C")
                        .foregroundColor(temp > 0 ? .black : .white)
                }
            }
        }
    }
}

struct TemperatureColorView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureColorView()
    }
}

//Color(hue: 9/360, saturation: 0.83, brightness: 0.56) // 55°
//Color(hue: 23/360, saturation: 0.75, brightness: 0.9) // 30°
//Color(hue: 36/360, saturation: 0.73, brightness: 0.91) // 25°
//Color(hue: 54/360, saturation: 0.62, brightness: 0.86) // 20°
//Color(hue: 91/360, saturation: 0.75, brightness: 0.9) // 15°
//Color(hue: 175/360, saturation: 0.75, brightness: 0.9) // 10°
//Color(hue: 200/360, saturation: 0.75, brightness: 0.9) // 0°
//Color(hue: 216/360, saturation: 0.59, brightness: 0.9) // -10°
//Color(hue: 226/360, saturation: 0.66, brightness: 0.87) // -20°
//Color(hue: 237/360, saturation: 0.66, brightness: 0.69) // -30°
//Color(hue: 254/360, saturation: 0.77, brightness: 0.44)] // -40°
extension Color {
    init(temperature: Float) {
        var hue = Float(254)
        if temperature < -30 {
            hue = 237 - (temperature + 30) * (254-237)/10
        } else if temperature < -20 {
            hue = 226 - (temperature + 20) * (237-226)/10
        } else if temperature < -10 {
            hue = 216 - (temperature + 10) * (226-216)/10
        } else if temperature < 0 {
            hue = 200 - (temperature + 0) * (216-200)/10
        } else if temperature < 10 {
            hue = 200 - temperature * (200-175)/10
        } else if temperature < 15 {
            hue = 175 - (temperature - 10) * (175-91)/5
        } else if temperature < 20 {
            hue = 91 - (temperature - 15) * (91-54)/5
        } else if temperature < 25 {
            hue = 54 - (temperature - 20) * (54-36)/5
        } else if temperature < 30 {
            hue = 36 - (temperature - 25) * (36-23)/5
        } else if temperature < 50 {
            hue = 9 - (temperature - 50) * (23-9)/20
        } else {
            hue = 9
        }
        self = Color(hue: Double(hue/360), saturation: 0.75, brightness: 0.9)
    }
}
