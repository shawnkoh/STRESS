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

    init() {
        self.components = []
    }

    /// Adds a component to the entity.
    func addComponent(_ component: GKComponent) {
        component.entity = self
        components.append(component)
        component.didAddToEntity(self)
    }

    func removeComponent<ComponentType>(ofType componentClass: ComponentType.Type) where ComponentType: GKComponent {
        if let component = component(ofType: componentClass) {
            if let index = components.firstIndex(of: component) {
                component.willRemoveFromEntity(self)
                components.remove(at: index)
            }
        }
    }

    func component<ComponentType>(ofType: ComponentType.Type) -> ComponentType? where ComponentType: GKComponent {
        for component in components {
            if let component = component as? ComponentType {
                return component
            }
        }
        return nil
    }
}

extension GKEntity: Equatable {
    static func == (lhs: GKEntity, rhs: GKEntity) -> Bool {
        lhs.id == rhs.id
    }
}
