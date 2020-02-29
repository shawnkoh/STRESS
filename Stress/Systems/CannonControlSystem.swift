//
//  CannonControlSystem.swift
//  Stress
//
//  Created by Shawn Koh on 24/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class CannonControlSystem: GKSystem {
    weak var controller: UIView? {
        didSet {
            controller?.isUserInteractionEnabled = true

            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(rotate(_:)))
            controller?.addGestureRecognizer(panGesture)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shoot(_:)))
            controller?.addGestureRecognizer(tapGesture)
        }
    }

    init(scene: GKScene) {
        super.init(scene: scene,
                   componentClasses: [TransformComponent.self,
                                      VisualComponent.self,
                                      RotatableComponent.self,
                                      FiringComponent.self,
                                      AmmoComponent.self])
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
            guard
                let controller = controller,
                let rotatableComponent = $0.component(ofType: RotatableComponent.self)
            else {
                fatalError("Entity does not have a RotatableComponent")
            }
            let tapLocation = sender.location(in: controller)
            let offset = initialTapLocation.x - tapLocation.x
            let relativeOffset = offset / controller.frame.width * Settings.Cannon.sensitivity

            let minAngle = Settings.Cannon.minAngle
            let maxAngle = Settings.Cannon.maxAngle

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
        guard
            sender.state == .ended,
            !scene.entities.contains(where: { $0 is Ball })
        else {
            return
        }
        entities.forEach { entity in
            guard
                let cannonTransformComponent = entity.component(ofType: TransformComponent.self),
                let cannonRotatableComponent = entity.component(ofType: RotatableComponent.self),
                let cannonFiringComponent = entity.component(ofType: FiringComponent.self),
                let cannonAmmoComponent = entity.component(ofType: AmmoComponent.self)
            else {
                fatalError("Entity does not have a RotatableComponent")
            }
            guard cannonAmmoComponent.ammo > 0 else {
                return
            }
            cannonAmmoComponent.ammo -= 1

            let dx = Settings.Ball.speed * -sin(cannonRotatableComponent.angle)
            let dy = Settings.Ball.speed * cos(cannonRotatableComponent.angle)
            let projectileVelocity = CGVector(dx: dx, dy: dy)

            let projectile = createProjectile(constructor: cannonFiringComponent.projectileConstructor,
                                              position: cannonTransformComponent.position,
                                              velocity: projectileVelocity)
            scene.addEntity(projectile)
            (scene as? LevelPlayingScene)?.parent.ammoLabel.text = "Shots left: \(cannonAmmoComponent.ammo)"
        }
    }

    private func createProjectile(constructor: () -> GKEntity, position: CGPoint, velocity: CGVector) -> GKEntity {
        let projectile = constructor()
        guard
            let transformComponent = projectile.component(ofType: TransformComponent.self),
            let physicsBody = projectile.component(ofType: PhysicsComponent.self)?.physicsBody
                as? BKPhysicsBodyWithVolume
        else {
            fatalError("Projectile does not have the required components")
        }
        transformComponent.position = position
        physicsBody.velocity = velocity
        return projectile
    }
}
