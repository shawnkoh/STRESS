//
//  BKPhysicsBodyWithVolume.swift
//  Bounce
//
//  Created by Shawn Koh on 14/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// A volume-based BKPhysicsBody.
protocol BKPhysicsBodyWithVolume: BKPhysicsBody {
    var center: CGPoint { get set }

    // MARK: Physical Properties

    /// The mass of the body, in kilograms.
    var mass: CGFloat { get set }

    // https://en.wikipedia.org/wiki/Drag_coefficient
    var dragCoefficient: CGFloat { get set }

    /// The bounciness of the physics body.
    /// Caution: It must be at least 0.0, and ideally less than or equal to 1.0
    /// If it is greater than 1.0, the physics body will gain velocity whenever it bounces..
    var restitution: CGFloat { get set }
    /// The area covered by the body.
    var area: CGFloat { get }

    // MARK: Inspecting a Physics Body's Velocity

    /// The physics body’s velocity vector, measured in meters per second.
    var velocity: CGVector { get set }

    // MARK: Defining how forces affect a Physical Property

    /// A Boolean value that indicates whether the physics body is moved by the physics simulation.
    /// If the value is false, the physics body ignores all forces and impulses applied to it.
    var isDynamic: Bool { get set }

    /// Tracks the number of times the physics body has hit the resting threshold.
    /// When the restingCount reaches the BKSettings.restingCountThreshold, the physics body is marked as resting.
    var restingCount: Int { get set }

    func intersects(with body: BKPhysicsBody) -> Bool

    /**
    Returns the position of where the body should be when it just collided with the other body.
    This is used to overcome the problem of the physics bodies phasing into each other between simulations.
    If the bodies do not collide, returns nil.
    */
    func computePositionWhenContacting(with body: BKPhysicsBody) -> CGPoint?

    /**
     A description of the contact between two physics bodies.
     If the bodies do not contact, returns nil.
     */
    func computeContact(with body: BKPhysicsBody) -> BKPhysicsContact?

    /**
     Returns the collision vector after colliding with a PhysicsBody
     */
    func computeCollisionVector(with body: BKPhysicsBody) -> CGVector

    func computeCollisionVectors(with body: BKPhysicsBodyWithVolume) -> (CGVector, CGVector)

    /**
     Applies a force to the center of gravity of a physics body.
     The acceleration is applied for a single simulation step (one frame).
     - Parameters:
        - force: A vector that describes how much force was applied in each dimension. The force is measured in Netwons.
     */
    func applyForce(_ force: CGVector)
}

extension BKPhysicsBodyWithVolume {
    func applyForce(_ force: CGVector) {
        velocity += force / mass
    }
}
