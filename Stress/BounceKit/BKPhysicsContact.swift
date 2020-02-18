//
//  BKPhysicsContact.swift
//  Bounce
//
//  Created by Shawn Koh on 11/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

struct BKPhysicsContact {
    /// The first body in the contact.
    let bodyA: BKPhysicsBody
    /// The second body in the contact.
    let bodyB: BKPhysicsBody
    /// The contact point between the two physics bodies, in scene coordinates.
    let contactPoint: CGPoint
}
