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
    init(scene: GKScene) {
        super.init(scene: scene, requiredComponents: [TransformComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach { entity in
            guard let transformComponent = entity.component(ofType: TransformComponent.self) else {
                fatalError("Could not retrieve the Transform Component")
            }

            if let view = entity.component(ofType: VisualComponent.self)?.view {
                view.center = transformComponent.position

                if let rotatableComponent = entity.component(ofType: RotatableComponent.self) {
                    view.transform = CGAffineTransform(rotationAngle: rotatableComponent.angle)
                }
            }

            if let physicsBody = entity.component(ofType: PhysicsComponent.self)?.physicsBody {
                switch physicsBody {
                case let circle as BKPhysicsCircle:
                    circle.center = transformComponent.position
                case let triangle as BKPhysicsTriangle:
                    triangle.moveCentroidTo(point: transformComponent.position)
                default:
                    ()
                }
            }
        }
    }
}
