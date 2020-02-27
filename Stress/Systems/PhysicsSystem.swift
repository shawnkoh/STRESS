//
//  PhysicsSystem.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PhysicsSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [PhysicsComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.filter { $0.component(ofType: DidAttachPhysicsComponent.self ) == nil }
                .forEach { entity in
                    guard let physicsBody = entity.component(ofType: PhysicsComponent.self)?.physicsBody else {
                        fatalError("Could not access visual component")
                    }

                    scene.physicsWorld.addBody(physicsBody)

                    if let transformComponent = entity.component(ofType: TransformComponent.self) {
                        physicsBody.delegate = transformComponent
                    }

                    entity.addComponent(DidAttachPhysicsComponent())
                }
    }
}
