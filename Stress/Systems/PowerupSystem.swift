//
//  PowerupSystem.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

/// This system serves as the actor for the powerups.
class PowerupSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [SpaceBlastComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        let pegs = scene.entities(ofType: Peg.self)

        entities.forEach { ball in
            guard
                let ballView = ball.component(ofType: VisualComponent.self)?.view as? UIImageView,
                let ballPosition = ball.component(ofType: TransformComponent.self)?.position
            else {
                fatalError("Could not access components")
            }
            let powerupView = ballView.subviews[0]
            let powerupRadius = powerupView.frame.width / 2

            pegs.forEach { peg in
                guard
                    let pegPosition = peg.component(ofType: TransformComponent.self)?.position,
                    let pegDiameter = peg.component(ofType: VisualComponent.self)?.view.frame.width
                else {
                    fatalError("Could not access components")
                }
                let pegRadius = pegDiameter / 2

                if ballPosition.distance(to: pegPosition) < powerupRadius + pegRadius {
                    peg.addComponent(DidHitComponent())
                }
            }
        }
    }
}
