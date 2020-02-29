//
//  DrawSpookyBallSystem.swift
//  Stress
//
//  Created by Shawn Koh on 1/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

class DrawSpookyBallSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene,
                   requiredComponents: [CollisionComponent.self, SpookyBallComponent.self],
                   excludedComponents: [DidDrawSpookyBallComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach { ball in
            guard let view = ball.component(ofType: VisualComponent.self)?.view as? UIImageView else {
                fatalError("Unable to access ball's components")
            }

            view.image = Settings.Ball.spookyImage

            ball.addComponent(DidDrawSpookyBallComponent())
        }
    }
}
