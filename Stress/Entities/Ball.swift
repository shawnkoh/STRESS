//
//  Ball.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/**
 `Ball` is an entity that represents a ball in Stress.
*/
class Ball: GKEntity {
    init(center: CGPoint, velocity: CGVector, radius: CGFloat = Settings.Ball.radius) {
        super.init()

        let transformComponent = TransformComponent(position: center)
        addComponent(transformComponent)

        let diameter = radius * 2
        let view = UIImageView(frame: .zero)
        view.image = Settings.Ball.image
        view.bounds.size = CGSize(width: diameter, height: diameter)
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        let physicsBody = BKPhysicsCircle(center: center, radius: radius, mass: 1.125, velocity: velocity)
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody)
        addComponent(physicsComponent)

        addComponent(CollisionComponent())
    }
}
