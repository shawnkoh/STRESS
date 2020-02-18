//
//  MovementComponent.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

class MovementComponent: GKComponent {
    var visualComponent: VisualComponent {
        guard let component = entity?.component(ofType: VisualComponent.self) else {
            fatalError("MovementComponent requires an entity with a Physics Component")
        }
        return component
    }
    var physicsComponent: PhysicsComponent {
        guard let component = entity?.component(ofType: PhysicsComponent.self) else {
            fatalError("MovementComponent requires an entity with a Physics Component")
        }
        return component
    }

    override func didAddToEntity() {
        physicsComponent.physicsBody.delegate = entity?.component(ofType: MovementComponent.self)
    }
}

extension MovementComponent: BKPhysicsBodyDelegate {
    func didUpdate(body: BKPhysicsBody) {
        if let body = body as? BKPhysicsBodyWithVolume {
            visualComponent.view.center = body.center
        }
    }
}
