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
    let requiredComponents: [GKComponent.Type]
    let excludedComponents: [GKComponent.Type]
    let requiredTypes: Set<String>
    let excludedTypes: Set<String>

    init(scene: GKScene, requiredComponents: [GKComponent.Type] = [], excludedComponents: [GKComponent.Type] = []) {
        self.scene = scene
        self.requiredComponents = requiredComponents
        self.excludedComponents = excludedComponents
        self.requiredTypes = Set(requiredComponents.map { NSStringFromClass($0) })
        self.excludedTypes = Set(excludedComponents.map { NSStringFromClass($0) })
    }

    var entities: [GKEntity] {
        scene.entities.compactMap {
            containsComponents($0) ? $0 : nil
        }
    }

    func entities<T>(entityType: T.Type,
                     requiredComponents: [GKComponent.Type],
                     excludedComponents: [GKComponent.Type]) -> [T] where T: GKEntity {
        scene.entities(ofType: T.self)
            .filter {
                let types = Set($0.components.keys)
                return types.isDisjoint(with: excludedTypes) && requiredTypes.isSubset(of: types)
            }
    }

    private func containsComponents(_ entity: GKEntity) -> Bool {
        requiredTypes.isSubset(of: entity.components.keys)
    }

    // MARK: Methods meant to be overriden

    /// This method is meant to be overriden.
    func willRemoveFromScene(_ scene: GKScene) {}
    /// This method is meant to be overriden.
    func didAddToScene(_ scene: GKScene) {}
    /// Tells all component instances managed by the system to perform their custom periodic actions.
    func update(deltaTime: TimeInterval) {}
}
