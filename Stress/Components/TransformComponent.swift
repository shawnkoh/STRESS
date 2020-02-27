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
    var position: CGPoint

    // TODO: add scale
    // should not do size because that belongs to the visual and physics component itself
    // var scale: CGFloat

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
