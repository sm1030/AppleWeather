//
//  MapTemperatureLegentView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 25/08/2022.
//

import SwiftUI

struct MapTemperatureLegentView: View {
    
    let temperatureColors: [Color] = [
        Color(temperature:  55),
        Color(temperature:  45),
        Color(temperature:  40),
        Color(temperature:  35),
        Color(temperature:  30),
        Color(temperature:  27),
        Color(temperature:  25),
        Color(temperature:  22),
        Color(temperature:  20),
        Color(temperature:  17),
        Color(temperature:  15),
        Color(temperature:  13),
        Color(temperature:  10),
        Color(temperature:  7),
        Color(temperature:  5),
        Color(temperature:  3),
        Color(temperature:  0),
        Color(temperature:  -5),
        Color(temperature:  -10),
        Color(temperature:  -15),
        Color(temperature:  -20),
        Color(temperature:  -25),
        Color(temperature:  -30),
        Color(temperature: -35),
        Color(temperature: -40),
        Color(temperature: -45)]
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("Temperature")
                .font(.caption).fontWeight(.medium)
                .foregroundColor(.clear)
                .padding(10)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("55")
                Text("30")
                Text("20")
                Text("10")
                Text("0")
                Text("-20")
                Text("-40")
            }
            .font(.caption)
            .foregroundColor(Color(hex: "454B39"))
            .padding(.leading, 22)
            .background {
                HStack {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.linearGradient(Gradient(colors: temperatureColors), startPoint: .top, endPoint: .bottom))
                        .frame(width: 4)
                        .offset(x: 7)
                    Spacer()
                }
            }
            .padding(.vertical, 10)
        }
        .background(RoundedCorners(tl: 0, tr: 0, bl: 10, br: 10).fill(.thinMaterial))
    }
}

struct MapTemperatureLegentView_Previews: PreviewProvider {
    static var previews: some View {
        MapTemperatureLegentView()
    }
}
