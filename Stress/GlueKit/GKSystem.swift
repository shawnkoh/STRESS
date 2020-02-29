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
        scene.entities.filter { !containsExcludedComponents($0) && containsRequiredComponents($0) }
    }

    func entities<T>(entityType: T.Type,
                     requiredComponents: [GKComponent.Type],
                     excludedComponents: [GKComponent.Type]) -> [T] where T: GKEntity {
        let requiredTypes = Set(requiredComponents.map { NSStringFromClass($0) })
        let excludedTypes = Set(excludedComponents.map { NSStringFromClass($0) })
        return scene
            .entities(ofType: T.self)
            .filter {
                excludedTypes.isDisjoint(with: $0.components.keys) &&
                    requiredTypes.isSubset(of: $0.components.keys)
            }
    }

    func containsRequiredComponents(_ entity: GKEntity) -> Bool {
        requiredTypes.isSubset(of: entity.components.keys)
    }

    func containsExcludedComponents(_ entity: GKEntity) -> Bool {
        !excludedTypes.isDisjoint(with: entity.components.keys)
    }

    /// Tells all component instances managed by the system to perform their custom periodic actions.
    /// This method is meant to be overriden.
    func update(deltaTime: TimeInterval) {}
}
