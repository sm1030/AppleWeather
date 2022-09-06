//
//  FontViewerView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 09/08/2022.
//

import SwiftUI

struct FontViewerView: View {
    let allFontNames = UIFont.familyNames
        .flatMap { UIFont.fontNames(forFamilyName: $0) }
    
    let testText = "Now 14 15"
    
    var body: some View {
        ScrollView {
            VStack {
//                Text(testText)
//                    .font(.largeTitle)
//                Text(".largeText")
//                    .padding(.bottom)
                
                Text(testText)
                    .font(.title)
                Text(".title")
                    .padding(.bottom)
                
                Text(testText)
                    .font(.title2)
                Text(".title2")
                    .padding(.bottom)
                
                Text(testText)
                    .font(.title3)
                Text(".title3")
                    .padding(.bottom)
                
                Text(testText)
                    .font(.headline)
                Text(".headline")
                    .padding(.bottom)
            }
            VStack {
                Text(testText)
                    .font(.body)
                Text(".body")
                    .padding(.bottom)
                
                Text(testText)
                    .font(.callout)
                Text(".callout")
                    .padding(.bottom)
                
                Text(testText)
                    .font(.subheadline)
                Text(".subheadline")
                    .padding(.bottom)
                
                Text(testText)
                    .font(.footnote)
                Text(".footnote")
                    .padding(.bottom)
            }
            VStack {
                Text(testText)
                    .font(.caption)
                Text(".caption")
                    .padding(.bottom)
                
                Text(testText)
                    .font(.caption2)
                Text(".caption2")
                    .padding(.bottom)
            }
            
            List(allFontNames, id: \.self) { name in
                Text(testText)
                    .font(Font.custom(name, size: 12))
                Text(name)
                    .font(Font.custom(name, size: 12))
            }
        }
    }
}

struct FontViewerView_Previews: PreviewProvider {
    static var previews: some View {
        FontViewerView()
    }
}
