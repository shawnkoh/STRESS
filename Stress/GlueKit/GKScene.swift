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
    let physicsWorld = BKPhysicsWorld()
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
    }

    /// Adds an entity to the list of entities managed by the scene.
    func addEntity(_ entity: GKEntity) {
        entities.append(entity)
    }

    /// Removes an entity from the list of entities managed by the scene.
    func removeEntity(_ entity: GKEntity) {
        if let index = entities.firstIndex(of: entity) {
            entities.remove(at: index)
        }
    }

    /// A convenience variable to retrieve all entities of type `EntityType`.
    func entities<EntityType: GKEntity>(ofType: EntityType.Type) -> [EntityType] {
        entities.compactMap {
            $0 as? EntityType
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
    func didMove(to view: GKView) {}
}

extension GKScene: Equatable {
    static func == (lhs: GKScene, rhs: GKScene) -> Bool {
        lhs.id == rhs.id
    }
}
