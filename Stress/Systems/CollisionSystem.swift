//
//  CollisionSystem.swift
//  Stress
//
//  Created by Shawn Koh on 25/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

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
                resolveCollision(ball: ball, peg: peg)
            case let exit as Exit:
                resolveCollision(ball: ball, exit: exit)
            default:
                ()
            }
        default:
            ()
        }
    }

    private func resolveCollisionEnd(entityA: GKEntity, entityB: GKEntity) {}

    private func resolveCollision(ball: Ball, peg: Peg) {
        peg.isHit = true
    }

    private func resolveCollision(ball: Ball, exit: Exit) {
        scene.entities(ofType: Peg.self)
            .filter { $0.isHit }
            .forEach { scene.removeEntity($0) }
        scene.removeEntity(ball)
    }
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
