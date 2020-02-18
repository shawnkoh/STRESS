//
//  PhysicsComponent.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/**
 A `PhysicsComponent` is a component that attaches to a `GKEntity`.
 It registers the entity in Stress's physics simulation.
 */
class PhysicsComponent: GKComponent {
    let physicsBody: BKPhysicsBody

    init(physicsBody: BKPhysicsBody) {
        self.physicsBody = physicsBody
        super.init()
    }

    override func didAddToEntity() {
        entity?.scene?.physicsWorld.addBody(physicsBody)
    }

    override func willRemoveFromEntity() {
        entity?.scene?.physicsWorld.removeBody(physicsBody)
    }
}
