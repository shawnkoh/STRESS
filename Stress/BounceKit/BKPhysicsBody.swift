//
//  BKPhysicsBody.swift
//  Bounce
//
//  Created by Shawn Koh on 10/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import CoreGraphics

/// An object that adds physics simulations to a node.
class BKPhysicsBody: Identifiable {
    let uuid = UUID().uuidString
    /**
     A Boolean property that indicates whether the object is at rest within the physics simulation.
     This property is automatically set to true by the physics simulation when it determines that the body is at rest.
     This means that the body is at rest on another body in the system.
     Resting bodies do not participate in the physics simulation until an impulse is applied to the object or
     another object collides with it. This improves the performance of the physics simulation.
     If all bodies in the world are resting, the entire simulation is at rest, reducing the number of calculations
     that are performed by the physics world.
     */
    var isResting: Bool

    // MARK: BKPhysicsBodyDelegate

    weak var delegate: BKPhysicsBodyDelegate?

    // MARK: Initialisers

    init(isResting: Bool = false) {
        self.isResting = isResting
        delegate?.didAppear(body: self)
    }

    deinit {
        delegate?.didRemove(body: self)
    }
}

extension BKPhysicsBody: Equatable {
    static func == (lhs: BKPhysicsBody, rhs: BKPhysicsBody) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
