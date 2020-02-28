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
    var components: [String: GKComponent] = [:]

    /// Adds a component to the entity.
    func addComponent(_ component: GKComponent) {
        let type = componentType(of: component)
        guard components[type] == nil else {
            return
        }
        components[type] = component
        component.didAddToEntity(self)
    }

    func removeComponent<ComponentType>(ofType componentClass: ComponentType.Type) where ComponentType: GKComponent {
        let type = componentType(ofType: componentClass)
        components[type] = nil
    }

    func component<ComponentType>(ofType type: ComponentType.Type) -> ComponentType? where ComponentType: GKComponent {
        let type = componentType(ofType: type)
        return components[type] as? ComponentType
    }

    private func componentType(ofType type: GKComponent.Type) -> String {
        NSStringFromClass(type)
    }

    private func componentType(of component: GKComponent) -> String {
        componentType(ofType: type(of: component))
    }
}

extension GKEntity: Equatable {
    static func == (lhs: GKEntity, rhs: GKEntity) -> Bool {
        lhs.id == rhs.id
    }
}
