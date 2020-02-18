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
    init(center: CGPoint, velocity: CGVector, radius: CGFloat = StressSettings.defaultBallRadius) {
        super.init()

        let diameter = radius * 2
        let view = UIImageView(frame: .zero)
        view.image = StressSettings.defaultBallImage
        view.center = center
        view.bounds.size = CGSize(width: diameter, height: diameter)
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        let physicsBody = BKPhysicsCircle(center: center, radius: radius, mass: 1.125, velocity: velocity)
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody)
        addComponent(physicsComponent)

        let movementComponent = MovementComponent()
        addComponent(movementComponent)
    }
}

extension Ball: GKContactNotifiable {
    func contactDidBegin(with entity: GKEntity) {
        switch entity {
        case let peg as Peg:
            peg.isHit = true

        case _ as Exit:
            scene?.entities(ofType: Peg.self)
                .filter { $0.isHit }
                .forEach { scene?.removeEntity($0) }
            scene?.removeEntity(self)

        default:
            ()
        }
    }
}
