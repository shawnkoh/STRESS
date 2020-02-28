//
//  CollisionSystem.swift
//  Stress
//
//  Created by Shawn Koh on 25/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class CollisionSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [CollisionComponent.self])
        scene.physicsWorld.contactDelegate = self
    }

    private func resolveCollisionBegin(entityA: GKEntity, entityB: GKEntity) {
        switch entityA {
        case let ball as Ball:
            switch entityB {
            case let peg as Peg:
                if peg.component(ofType: PowerupComponent.self) != nil {
                    ball.addComponent(SpaceBlastComponent())
                }
                peg.addComponent(DidHitComponent())
            case let exit as Exit:
                ball.addComponent(WillDestroyComponent())
                exit.addComponent(DidHitComponent())
            case let bucket as Bucket:
                ball.addComponent(WillDestroyComponent())
                bucket.addComponent(DidHitComponent())
            default:
                ()
            }
        default:
            ()
        }
    }

    private func resolveCollisionEnd(entityA: GKEntity, entityB: GKEntity) {}
}

extension CollisionSystem: BKPhysicsContactDelegate {
    private func entity(withPhysicsBody physicsBody: BKPhysicsBody) -> GKEntity {
        guard let entity = (scene.entities.first { entity in
            physicsBody == entity.component(ofType: PhysicsComponent.self)?.physicsBody
        }) else {
            fatalError("Entity does not belong to the scene")
        }
        return entity
    }

    func didBegin(_ contact: BKPhysicsContact) {
        let entityA = entity(withPhysicsBody: contact.bodyA)
        let entityB = entity(withPhysicsBody: contact.bodyB)

        if entityA.component(ofType: CollisionComponent.self) != nil {
            resolveCollisionBegin(entityA: entityA, entityB: entityB)
        }

        if entityB.component(ofType: CollisionComponent.self) != nil {
            resolveCollisionBegin(entityA: entityB, entityB: entityA)
        }
    }

    func didEnd(_ contact: BKPhysicsContact) {
        let entityA = entity(withPhysicsBody: contact.bodyA)
        let entityB = entity(withPhysicsBody: contact.bodyB)

        if entityA.component(ofType: CollisionComponent.self) != nil {
            resolveCollisionEnd(entityA: entityA, entityB: entityB)
        }

        if entityB.component(ofType: CollisionComponent.self) != nil {
            resolveCollisionEnd(entityA: entityB, entityB: entityA)
        }
    }
}
