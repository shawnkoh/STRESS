//
//  UnstuckPegSystem.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class UnstuckPegSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, requiredComponents: [PhysicsComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        let balls = entities.compactMap { ($0 as? Ball)?.component(ofType: PhysicsComponent.self)?.physicsBody }
        guard !balls.isEmpty && balls.allSatisfy({ $0.isResting }) else {
            return
        }

        balls.forEach { $0.isResting = false }

        entities
            .compactMap { $0 as? Peg }
            .filter { $0.component(ofType: DidHitComponent.self) != nil }
            .forEach { $0.addComponent(WillDestroyComponent()) }
    }
}
