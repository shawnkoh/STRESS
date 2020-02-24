//
//  TransformSystem.swift
//  Stress
//
//  Created by Shawn Koh on 24/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import CoreGraphics

class TransformSystem: GKSystem {
    init() {
        super.init(componentClasses: [TransformComponent.self, RotatableComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach { entity in
            guard
                let transformComponent = entity.component(ofType: TransformComponent.self),
                let rotatableComponent = entity.component(ofType: RotatableComponent.self)
            else {
                fatalError("Entity does not have the required components")
            }

            if let view = entity.component(ofType: VisualComponent.self)?.view {
                view.center = transformComponent.position
                view.transform = CGAffineTransform(rotationAngle: rotatableComponent.angle)
            }

            if let physicsBody = entity.component(ofType: PhysicsComponent.self)?.physicsBody {
                if let circle = physicsBody as? BKPhysicsCircle {
                    circle.center = transformComponent.position
                }
            }
        }
    }
}
