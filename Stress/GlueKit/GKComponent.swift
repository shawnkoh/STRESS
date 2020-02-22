//
//  GKComponent.swift
//  Bounce
//
//  Created by Shawn Koh on 14/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// The abstract superclass for creating objects that add specific gameplay functionality to an entity.
class GKComponent: Identifiable {
    let id = UUID().uuidString
    weak var entity: GKEntity?

    func update(deltaTime: TimeInterval) {}

    func didAddToEntity(_ entity: GKEntity) {}
    func willRemoveFromEntity(_ entity: GKEntity) {}
    func didAddToScene(_ scene: GKScene) {}
    func willRemoveFromScene(_ scene: GKScene) {}
}

extension GKComponent: Equatable {
    static func == (lhs: GKComponent, rhs: GKComponent) -> Bool {
        lhs.id == rhs.id
    }
}
