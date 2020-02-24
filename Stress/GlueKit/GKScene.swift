//
//  GKScene.swift
//  Bounce
//
//  Created by Shawn Koh on 16/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import CoreGraphics

/// An object that organizes all of the active GlueKit content.
class GKScene: Identifiable {
    let id = UUID().uuidString
    /// The list of EntityKit entities managed by the scene.
    var entities = [GKEntity]()
    private(set) var systems: [GKSystem] = .init()
    /// The physics simulation associated with the scene.
    var physicsWorld: BKPhysicsWorld {
        guard let physicsWorld = _physicsWorld else {
            fatalError("Physics World has not been initialised")
        }
        return physicsWorld
    }
    private var _physicsWorld: BKPhysicsWorld?
    /// The view that is currently presenting this scene
    weak var view: GKView? {
        didSet {
            if let view = view {
                didMove(to: view)
            }
        }
    }
    /// A delegate to be called during the animation loop.
    weak var delegate: GKSceneDelegate?

    /// Initializes a new scene object.
    /// - Returns: A newly initialized scene object.
    init() {}

    func addSystem(_ system: GKSystem) {
        systems.append(system)
        entities.forEach { system.addEntity($0) }
    }

    /// Adds an entity to the list of entities managed by the scene.
    func addEntity(_ entity: GKEntity) {
        entities.append(entity)
        entity.scene = self

        systems.forEach { $0.addEntity(entity) }
    }

    /// Removes an entity from the list of entities managed by the scene.
    func removeEntity(_ entity: GKEntity) {
        if let index = entities.firstIndex(of: entity) {
            entities.remove(at: index)
            entity.scene = nil
        }

        systems.forEach { $0.removeEntity(entity) }
    }

    func removeAllEntities() {
        entities.forEach { removeEntity($0) }
    }

    /// A convenience variable to retrieve all entities of type `EntityType`.
    func entities<EntityType: GKEntity>(ofType: EntityType.Type) -> [EntityType] {
        entities.compactMap {
            $0 as? EntityType
        }
    }

    /// Convenience function to get an entity in the scene with the specified physics body.
    fileprivate func entity(withPhysicsBody physicsBody: BKPhysicsBody) -> GKEntity? {
        entities.first { entity in
            physicsBody == entity.component(ofType: PhysicsComponent.self)?.physicsBody
        }
    }

    /// Tells your app to perform any app-specific logic to update your scene.
    func update(timestep: CGFloat, updateFrequency: Int) {
        let deltaTime = timestep / updateFrequency
        delegate?.update(for: self)

        for _ in 1...updateFrequency {
            physicsWorld.simulate(timestep: deltaTime)
        }
        delegate?.didSimulatePhysics(for: self)

        systems.forEach { $0.update(deltaTime: TimeInterval(deltaTime)) }
        delegate?.didFinishUpdate(for: self)
    }

    /// Tells you when the scene is presented by a view.
    /// This method is meant to be overriden.
    func didMove(to view: GKView) {
        let size = view.frame.size
        _physicsWorld = BKPhysicsWorld(size: size)
        physicsWorld.contactDelegate = self
    }
}

extension GKScene: BKPhysicsContactDelegate {
    func didBegin(_ contact: BKPhysicsContact) {
        let entityA = entity(withPhysicsBody: contact.bodyA)
        let entityB = entity(withPhysicsBody: contact.bodyB)

        if let entityA = entityA as? GKContactNotifiable, let entityB = entityB {
            entityA.contactDidBegin(with: entityB)
        }

        if let entityB = entityB as? GKContactNotifiable, let entityA = entityA {
            entityB.contactDidBegin(with: entityA)
        }
    }

    func didEnd(_ contact: BKPhysicsContact) {
        let entityA = entity(withPhysicsBody: contact.bodyA)
        let entityB = entity(withPhysicsBody: contact.bodyB)

        if let entityA = entityA as? GKContactNotifiable, let entityB = entityB {
            entityA.contactDidEnd(with: entityB)
        }

        if let entityB = entityB as? GKContactNotifiable, let entityA = entityA {
            entityB.contactDidEnd(with: entityA)
        }
    }
}

extension GKScene: Equatable {
    static func == (lhs: GKScene, rhs: GKScene) -> Bool {
        lhs.id == rhs.id
    }
}
