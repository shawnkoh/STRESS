//
//  GKSystem.swift
//  Stress
//
//  Created by Shawn Koh on 24/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class GKSystem {
    unowned let scene: GKScene
    let componentClasses: [GKComponent.Type]
    private(set) var entities: [GKEntity] = []

    init(scene: GKScene, componentClasses: [GKComponent.Type]) {
        self.scene = scene
        self.componentClasses = componentClasses
    }

    @discardableResult
    func addEntity(_ entity: GKEntity) -> Bool {
        let entityComponentTypes = entity.components.map { type(of: $0) }
        guard componentClasses.allSatisfy({ componentClass in
            let contains = entityComponentTypes.firstIndex { entityComponentType in
                componentClass == entityComponentType
            }
            return contains != nil
        }) else {
            return false
        }
        entities.append(entity)
        return true
    }

    @discardableResult
    func removeEntity(_ entity: GKEntity) -> GKEntity? {
        if let index = entities.firstIndex(of: entity) {
            return entities.remove(at: index)
        }
        return nil
    }

    // MARK: Methods meant to be overriden

    /// This method is meant to be overriden.
    func willRemoveFromScene(_ scene: GKScene) {}
    /// This method is meant to be overriden.
    func didAddToScene(_ scene: GKScene) {}
    /// Tells all component instances managed by the system to perform their custom periodic actions.
    func update(deltaTime: TimeInterval) {}
}
