//
//  RainLightningScene.swift
//  AppleWeather
//
//  Created by Alexandre Malkov on 30/08/2022.
//

import Foundation
import SpriteKit
import SwiftUI

class RainLightningScene: SKScene {
    
    static var shared = RainLightningScene()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
         view.allowsTransparency = true
         
         if let rainEmitter = SKEmitterNode(fileNamed: "Rain.sks") {
             rainEmitter.position.y = self.frame.maxY
             rainEmitter.particlePositionRange.dx = self.frame.width * 2.5
        
             addChild(rainEmitter)
         }
     }
    
}
