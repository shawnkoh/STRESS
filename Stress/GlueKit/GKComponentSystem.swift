//
//  GKComponentSystem.swift
//  Bounce
//
//  Created by Shawn Koh on 16/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// Manages periodic update messages for all component objects of a specified class.
class GKComponentSystem<ComponentType> where ComponentType: GKComponent {
    /// The class of components managed by the component system.
    var componentClass: AnyClass

    /// The component system’s list of components.
    var components: [ComponentType] = []

    /// Initializes a component system to manage components of the specified class.
    init(componentClass: AnyClass) {
        self.componentClass = componentClass
    }

    /// Adds a component instance to the component system.
    func addComponent(_ component: ComponentType) {
        components.append(component)
    }

    /// Adds any instances of the component system’s component class in the specified entity to the component system.
    func addComponent(foundIn entity: GKEntity) {
        entity.components.forEach { component in
            if let component = component as? ComponentType {
                addComponent(component)
            }
        }
    }

    /// Removes the specified component instance from the component system.
    func removeComponent(_ component: ComponentType) {
        if let index = components.firstIndex(of: component) {
            components.remove(at: index)
        }
    }

    /// Removes any instances of the component system’s component class in the
    /// specified entity from the component system.
    func removeComponent(foundIn entity: GKEntity) {
        entity.components.forEach { component in
            if let component = component as? ComponentType {
                removeComponent(component)
            }
        }
    }

    /// Tells all component instances managed by the system to perform their custom periodic actions.
    func update(deltaTime: TimeInterval) {
        components.forEach { component in
            component.update(deltaTime: deltaTime)
        }
    }
}
