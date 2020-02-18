//
//  GKEntity.swift
//  Bounce
//
//  Created by Shawn Koh on 14/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// An object relevant to gameplay, with functionality entirely provided by a collection of component objects.
class GKEntity: Identifiable {
    let id = UUID().uuidString
    /// The entity’s list of components.
    var components: [GKComponent]
    weak var scene: GKScene? {
        willSet {
            guard scene != newValue else {
                return
            }
            if let scene = scene, newValue == nil {
                willRemoveFromScene(scene: scene)
            }
        }
        didSet {
            guard scene != oldValue else {
                return
            }

            if let scene = scene {
                didAddToScene(scene: scene)
            }
        }
    }

    init() {
        self.components = []
    }

    /// Adds a component to the entity.
    func addComponent(_ component: GKComponent) {
        component.entity = self
        components.append(component)
    }

    func removeComponent<ComponentType>(ofType componentClass: ComponentType.Type) where ComponentType: GKComponent {
        if let component = component(ofType: componentClass) {
            if let index = components.firstIndex(of: component) {
                component.willRemoveFromEntity()
                components.remove(at: index)
            }
        }
    }

    func component<ComponentType>(ofType: ComponentType.Type) -> ComponentType? {
        for component in components {
            if let component = component as? ComponentType {
                return component
            }
        }
        return nil
    }

    /// Notifies the entity that it has been assigned to a scene.
    private func didAddToScene(scene: GKScene) {
        components.forEach { component in
            component.didAddToEntity()
        }
    }

    private func willRemoveFromScene(scene: GKScene) {
        components.forEach { component in
            component.willRemoveFromEntity()
        }
    }
}

extension GKEntity: Equatable {
    static func == (lhs: GKEntity, rhs: GKEntity) -> Bool {
        lhs.id == rhs.id
    }
}
