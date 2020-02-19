//
//  TransformComponent.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// A component that defines the scale, rotation, and translation of an entity.
/// It is responsible for synchronizing all the various components that depend on it
class TransformComponent: GKComponent {
    var visualComponent: VisualComponent? {
        entity?.component(ofType: VisualComponent.self)
    }
    var physicsComponent: PhysicsComponent? {
        entity?.component(ofType: PhysicsComponent.self)
    }

    var position: CGPoint {
        didSet {
            visualComponent?.view.center = position

            if let volume = physicsComponent?.physicsBody as? BKPhysicsBodyWithVolume {
                volume.center = position
            }
        }
    }

    // var scale: CGFloat
    // should not do size because that belongs to the visual and physics component itself

    init(position: CGPoint) {
        self.position = position
    }
}

extension TransformComponent: BKPhysicsBodyDelegate {
    func didUpdate(body: BKPhysicsBody) {
        if let body = body as? BKPhysicsBodyWithVolume {
            if position != body.center {
                position = body.center
            }
        }
    }
}
