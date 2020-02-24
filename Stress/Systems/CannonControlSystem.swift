//
//  CannonControlSystem.swift
//  Stress
//
//  Created by Shawn Koh on 24/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class CannonControlSystem: GKSystem {
    unowned let controller: UIView

    init(controller: UIView) {
        self.controller = controller
        super.init(componentClasses: [TransformComponent.self, RotatableComponent.self, FiringComponent.self])

        controller.isUserInteractionEnabled = true

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(rotate(_:)))
        controller.addGestureRecognizer(panGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shoot(_:)))
        controller.addGestureRecognizer(tapGesture)
    }

    private var initialTapLocation: CGPoint = .zero

    @objc func rotate(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            initialTapLocation = sender.location(in: controller)
            return
        }

        guard sender.state == .changed else {
            return
        }
        entities.forEach {
            guard let rotatableComponent = $0.component(ofType: RotatableComponent.self) else {
                fatalError("Entity does not have a RotatableComponent")
            }
            let tapLocation = sender.location(in: controller)
            let offset = initialTapLocation.x - tapLocation.x
            let relativeOffset = offset / controller.frame.width * StressSettings.cannonSensitivity

            let minAngle = StressSettings.cannonMinAngle
            let maxAngle = StressSettings.cannonMaxAngle

            var angle = rotatableComponent.angle + relativeOffset * (maxAngle - minAngle)
            if angle < minAngle {
                angle = minAngle
            } else if angle > maxAngle {
                angle = maxAngle
            }

            rotatableComponent.angle = angle
        }
    }

    @objc func shoot(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }
        entities.forEach { entity in
            guard
                let cannonTransformComponent = entity.component(ofType: TransformComponent.self),
                let cannonRotatableComponent = entity.component(ofType: RotatableComponent.self),
                let cannonFiringComponent = entity.component(ofType: FiringComponent.self)
            else {
                fatalError("Entity does not have a RotatableComponent")
            }

            let projectile = cannonFiringComponent.projectileConstructor()
            guard
                let projectileTransformComponent = projectile.component(ofType: TransformComponent.self),
                let projectilePhysics = projectile.component(ofType: PhysicsComponent.self)?.physicsBody
                    as? BKPhysicsCircle
            else {
                fatalError("Projectile does not have the required components")
            }
            projectileTransformComponent.position = cannonTransformComponent.position
            let dx = StressSettings.defaultBallSpeed * -sin(cannonRotatableComponent.angle)
            let dy = StressSettings.defaultBallSpeed * cos(cannonRotatableComponent.angle)
            projectilePhysics.velocity = CGVector(dx: dx, dy: dy)
            entity.scene?.addEntity(projectile)
        }
    }
}
