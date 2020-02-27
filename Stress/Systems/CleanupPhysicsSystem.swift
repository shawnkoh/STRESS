//
//  CleanupPhysicsSystem.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class CleanupPhysicsSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [PhysicsComponent.self,
                                                    DidAttachPhysicsComponent.self,
                                                    WillDestroyComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach { entity in
            guard let physicsBody = entity.component(ofType: PhysicsComponent.self)?.physicsBody else {
                fatalError("Unable to access entity's Physics Component")
            }

            scene.physicsWorld.removeBody(physicsBody)

            entity.removeComponent(ofType: DidAttachPhysicsComponent.self)
        }
    }
}
