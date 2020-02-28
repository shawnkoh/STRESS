//
//  DrawPowerupSystem.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

class DrawPowerupSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [SpaceBlastComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.filter { $0.component(ofType: DidDrawPowerupComponent.self) == nil }
                .forEach { ball in
                    guard let ballView = ball.component(ofType: VisualComponent.self)?.view else {
                        fatalError("Unable to access ball's components")
                    }
                    let radius = Settings.Powerup.spaceBlastRadius
                    let diameter = radius * 2

                    let circle = UIView(frame: .zero)
                    circle.frame.size = .init(width: diameter, height: diameter)
                    circle.layer.cornerRadius = radius
                    circle.clipsToBounds = true
                    circle.backgroundColor = .green
                    circle.alpha = 0.3
                    circle.center = .init(x: 0, y: 0)
//                    print(circle.center)

                    ballView.addSubview(circle)
                    ball.addComponent(DidDrawPowerupComponent())
                }
    }
}
