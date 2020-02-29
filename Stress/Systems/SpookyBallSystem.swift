//
//  SpookyBallSystem.swift
//  Stress
//
//  Created by Shawn Koh on 1/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

/// This system serves as the actor for the `SpookyBall` powerup.
class SpookyBallSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene,
                   requiredComponents: [CollisionComponent.self,
                                        TransformComponent.self,
                                        SpookyBallComponent.self,
                                        WillDestroyComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities(entityType: Ball.self,
                 requiredComponents: requiredComponents,
                 excludedComponents: [DidRespawnSpookyBallComponent.self]).forEach { ball in
            guard let transform = ball.component(ofType: TransformComponent.self) else {
                fatalError("Unable to access ball's transform component")
            }
            print(transform.position)
            transform.position.y = 0
            print("moved position", transform.position)

            ball.addComponent(DidRespawnSpookyBallComponent())
            ball.removeComponent(ofType: WillDestroyComponent.self)
            print(ball.components.keys)
        }
    }
}
