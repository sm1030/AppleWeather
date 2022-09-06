//
//  TheRainView.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 30/08/2022.
//

import SwiftUI
import SpriteKit

struct TheRainView: View {
    
    let night: Bool
    
    var rainLightningScene: SKScene {
        let scene = RainLightningScene.shared
        scene.size = UIScreen.screenSize
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack {
            if night {
                Color.black
                    .ignoresSafeArea()
            } else {
                Color(hex: "274A60")
                    .ignoresSafeArea()
            }
        }
        Color.clear
            .overlay {
                SpriteView(scene: rainLightningScene, options: [.allowsTransparency])
                    .frame(width: UIScreen.screenWidth,
                           height: UIScreen.screenHeight)
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
            }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct TheRainView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "4288B6")
                .ignoresSafeArea()
            TheRainView(night: false)
        }
    }
}
