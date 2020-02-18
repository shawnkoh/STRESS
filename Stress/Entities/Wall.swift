//
//  Wall.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/**
 `Wall` is an entity that represents a wall in Stress.
*/
class Wall: GKEntity {
    init(from: CGPoint, to: CGPoint) {
        super.init()
        let edge = BKPhysicsEdge(from: from, to: to)
        let physicsComponent = PhysicsComponent(physicsBody: edge)
        addComponent(physicsComponent)
    }
}
