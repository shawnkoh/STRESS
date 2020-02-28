//
//  BKPhysicsCircle.swift
//  Bounce
//
//  Created by Shawn Koh on 14/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// An object that adds physics simulations to a node.
class BKPhysicsCircle: BKPhysicsBody, BKPhysicsBodyWithVolume {
    var center: CGPoint {
        didSet {
            delegate?.didUpdate(body: self)
        }
    }
    // MARK: Physical Properties

    /// The mass of the body, in kilograms.
    var mass: CGFloat

    var radius: CGFloat {
        didSet {
            delegate?.didUpdate(body: self)
        }
    }

    // https://en.wikipedia.org/wiki/Drag_coefficient
    var dragCoefficient: CGFloat
    /// The bounciness of the physics body.
    /// Caution: It must be at least 0.0, and ideally less than or equal to 1.0
    /// If it is greater than 1.0, the physics body will gain velocity whenever it bounces..
    var restitution: CGFloat {
        willSet {
            if restitution < 0 {
                fatalError("The restitution of a PhysicsBody cannot be less than 0")
            }
        }
    }
    /// The area covered by the body.
    var area: CGFloat {
        CGFloat.pi * radius * radius
    }

    // MARK: Inspecting a Physics Body's Velocity

    /// The physics body’s velocity vector, measured in meters per second.
    var velocity: CGVector

    // MARK: Defining how forces affect a Physical Property

    /// A Boolean value that indicates whether the physics body is moved by the physics simulation.
    var isDynamic: Bool

    var restingCount: Int = 0

    init(center: CGPoint,
         radius: CGFloat,
         mass: CGFloat = BKSettings.defaultMass,
         dragCoefficient: CGFloat = BKSettings.defaultDragCoefficient,
         restitution: CGFloat = BKSettings.defaultRestitution,
         velocity: CGVector = .zero,
         isDynamic: Bool = true,
         isResting: Bool = false) {
        self.center = center
        self.radius = radius
        self.mass = mass
        self.dragCoefficient = dragCoefficient
        self.restitution = restitution
        self.velocity = velocity
        self.isDynamic = isDynamic
        super.init(isResting: isResting)
    }

    func intersects(with body: BKPhysicsBody) -> Bool {
        if let edge = body as? BKPhysicsEdge {
            return intersects(withEdge: edge)
        }

        if let volumeBody = body as? BKPhysicsBodyWithVolume {
            return intersects(withVolume: volumeBody)
        }

        fatalError("Unsupported BKPhysicsBody subclass")
    }

    private func intersects(withEdge edge: BKPhysicsEdge) -> Bool {
        edge.intersects(with: self)
    }

    private func intersects(withVolume body: BKPhysicsBodyWithVolume) -> Bool {
        if let body = body as? BKPhysicsCircle {
            return intersects(withCircle: body)
        }
        // TODO: Fallback to polygon intersection
        fatalError("Unsupported BKPhysicsBodyWithVolume subclass")
    }

    private func intersects(withCircle body: BKPhysicsCircle) -> Bool {
        center.distance(to: body.center) < radius + body.radius
    }

    // MARK: Compute position when contacting
    // Ball phases into peg, then backtracks using the computed position

    /**
     Returns the position of where the body should be if it was perfectly intersecting with the other body.
     If the bodies do not intersect, returns nil.
     */
    func computePositionWhenContacting(with body: BKPhysicsBody) -> CGPoint? {
        guard intersects(with: body) else {
            return nil
        }

        if let body = body as? BKPhysicsEdge {
            return computePositionWhenContacting(withEdge: body)
        }

        if let volumeBody = body as? BKPhysicsBodyWithVolume {
            return computePositionWhenContacting(withVolume: volumeBody)
        }

        // TODO: Fallback to a polygon algo
        fatalError("Unsupported type")
    }

    private func computePositionWhenContacting(withEdge edge: BKPhysicsEdge) -> CGPoint {
        // TODO: Optimise this by calculating the precise location instead of a while loop
        let unitVector = velocity / velocity.length
        var positionWhenContacting = center
        while edge.shortestDistance(to: positionWhenContacting) < radius {
            positionWhenContacting -= unitVector
        }
        return positionWhenContacting
    }

    private func computePositionWhenContacting(withVolume body: BKPhysicsBodyWithVolume) -> CGPoint {
        if let body = body as? BKPhysicsCircle {
            return computePositionWhenContacting(withCircle: body)
        }

        // TODO: Fallback to a polygon algo
        fatalError("Unsupported type")
    }

    private func computePositionWhenContacting(withCircle body: BKPhysicsCircle) -> CGPoint {
        // TODO: Find a better way to calculate the point of intersection. This is neither correct nor efficient
        let unitVector = velocity / velocity.length
        var intersectionPosition = center
        while intersectionPosition.distance(to: body.center) < radius + body.radius {
            intersectionPosition -= unitVector
        }
        return intersectionPosition
    }

    /**
     Returns the projected contact point between both bodies.
     If the bodies will not intersect, returns nil.
     */
    func computeContact(with body: BKPhysicsBody) -> BKPhysicsContact? {
        if let edge = body as? BKPhysicsEdge {
            return computeContact(withEdge: edge)
        }

        if let circle = body as? BKPhysicsCircle {
            return computeContact(withCircle: circle)
        }

        // TODO: Fallback to polygon
        fatalError("Unsupported BKPhysicsBody subclass")
    }

    private func computeContact(withEdge edge: BKPhysicsEdge) -> BKPhysicsContact? {
        let unitVector = velocity / velocity.length
        let line = BKLine(from: center, to: center + unitVector)

        if let intersectionPoint = line.intersectionPoint(to: edge) {
            return BKPhysicsContact(bodyA: self, bodyB: edge, contactPoint: intersectionPoint)
        } else {
            return nil
        }
    }

    private func computeContact(withCircle circle: BKPhysicsCircle) -> BKPhysicsContact? {
        // TODO: Not accurate because the midpoint is not necessarily their contact point
        BKPhysicsContact(bodyA: self,
                         bodyB: circle,
                         contactPoint: center.midpoint(to: circle.center))
    }

    func computeCollisionVector(with body: BKPhysicsBody) -> CGVector {
        if let edge = body as? BKPhysicsEdge {
            return computeCollisionVector(withEdge: edge)
        }

        fatalError("Unsupported BKPhysicsBody subclass")
    }

    private func computeCollisionVector(withEdge edge: BKPhysicsEdge) -> CGVector {
        // https://math.stackexchange.com/questions/13261/how-to-get-a-reflection-vector
        let edgeVector = CGVector(dx: edge.to.x - edge.from.x, dy: edge.to.y - edge.from.y)
        let normal1 = edgeVector.normalVectors.0
        let normal2 = edgeVector.normalVectors.1
        let inverseD = velocity * -1
        let angle1 = acos(inverseD.dot(normal1) / (inverseD.length * normal1.length)) * 180 / CGFloat.pi
        let angle2 = acos(inverseD.dot(normal2) / (inverseD.length * normal2.length)) * 180 / CGFloat.pi

        let normal = angle1 < angle2 ? normal1 : normal2
        let r = CGVector.computeReflectionVector(d: velocity, n: normal / normal.length)
        return r * restitution
    }

    func computeCollisionVectors(with body: BKPhysicsBodyWithVolume) -> (CGVector, CGVector) {
        let m1 = mass
        let m2 = body.mass
        let v1 = velocity
        let v2 = body.velocity

        if body.isResting || !body.isDynamic {
            // Ideal solution: https://en.wikipedia.org/wiki/Elastic_collision#Two-dimensional
            // Problem is that I'm not sure what the angle of deflection in ^ is supposed to be

            // So instead, use this
            // https://math.stackexchange.com/questions/13261/how-to-get-a-reflection-vector
            let v2ToV1 = CGVector(dx: center.x - body.center.x, dy: center.y - body.center.y)
            let r = CGVector.computeReflectionVector(d: v1, n: v2ToV1 / v2ToV1.length)
            let dampenedR = r * restitution
            return (dampenedR, .zero)
        }

        // https://en.wikipedia.org/wiki/Elastic_collision#Two-dimensional_collision_with_two_moving_objects
        let x1 = CGVector(dx: center.x, dy: center.y)
        let x2 = CGVector(dx: body.center.x, dy: body.center.y)

        let vel1 = v1 -
            ((2 * m2) / (m1 + m2)) *
            ((v1 - v2).dot(x1 - x2) / (x1 - x2).dot(x1 - x2)) *
            (x1 - x2)
        let vel2 = v2 -
            ((2 * m1) / (m1 + m2)) *
            ((v2 - v1).dot(x2 - x1) / (x2 - x1).dot(x2 - x1)) *
            (x2 - x1)

        return (vel1, vel2)
    }
}
