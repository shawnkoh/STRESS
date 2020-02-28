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
                    ballView.addSubview(circle)
                    circle.layer.cornerRadius = radius
                    circle.clipsToBounds = true
                    circle.backgroundColor = .green
                    circle.alpha = 0.3
                    circle.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        circle.centerXAnchor.constraint(equalTo: ballView.centerXAnchor),
                        circle.centerYAnchor.constraint(equalTo: ballView.centerYAnchor),
                        circle.widthAnchor.constraint(equalToConstant: diameter),
                        circle.heightAnchor.constraint(equalToConstant: diameter)
                    ])

                    ball.addComponent(DidDrawPowerupComponent())
                }
    }
}
