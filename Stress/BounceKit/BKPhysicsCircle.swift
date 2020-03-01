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
        switch body {
        case let edge as BKPhysicsEdge:
            return intersects(withEdge: edge)
        case let triangle as BKPhysicsTriangle:
            return intersects(withTriangle: triangle)
        case let circle as BKPhysicsCircle:
            return intersects(withCircle: circle)
        default:
            // TODO: Fallback to a polygon algo
            fatalError("Unsupported BKPhysicsBody subclass")
        }
    }

    private func intersects(withEdge edge: BKPhysicsEdge) -> Bool {
        edge.intersects(with: self)
    }

    private func intersects(withTriangle triangle: BKPhysicsTriangle) -> Bool {
        triangle.edges.contains { $0.intersects(with: self) }
    }

    private func intersects(withCircle circle: BKPhysicsCircle) -> Bool {
        center.distance(to: circle.center) < radius + circle.radius
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

        switch body {
        case let edge as BKPhysicsEdge:
            return computePositionWhenContacting(withEdge: edge)
        case let triangle as BKPhysicsTriangle:
            return computePositionWhenContacting(withTriangle: triangle)
        case let circle as BKPhysicsCircle:
            return computePositionWhenContacting(withCircle: circle)
        default:
            // TODO: Fallback to a polygon algo
            fatalError("Unsupported type")
        }
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

    private func computePositionWhenContacting(withTriangle triangle: BKPhysicsTriangle) -> CGPoint? {
        // TODO: Optimise this by calculating the precise location instead of a while loop
        let unitVector = velocity / velocity.length
        for edge in triangle.edges {
            var positionWhenContacting = center
            guard edge.intersects(with: self) else {
                continue
            }
            while edge.shortestDistance(to: positionWhenContacting) < radius {
                positionWhenContacting -= unitVector
            }
            return positionWhenContacting
        }
        return nil
    }

    private func computePositionWhenContacting(withCircle circle: BKPhysicsCircle) -> CGPoint {
        // TODO: Find a better way to calculate the point of intersection. This is neither correct nor efficient
        let unitVector = velocity / velocity.length
        var intersectionPosition = center
        while intersectionPosition.distance(to: circle.center) < radius + circle.radius {
            intersectionPosition -= unitVector
        }
        return intersectionPosition
    }

    /**
     Returns the projected contact point between both bodies.
     If the bodies will not intersect, returns nil.
     */
    func computeContact(with body: BKPhysicsBody) -> BKPhysicsContact? {
        switch body {
        case let edge as BKPhysicsEdge:
            return computeContact(withEdge: edge)
        case let triangle as BKPhysicsTriangle:
            return computeContact(withTriangle: triangle)
        case let circle as BKPhysicsCircle:
            return computeContact(withCircle: circle)
        default:
            // TODO: Fallback to polygon
            fatalError("Unsupported BKPhysicsBody subclass")
        }
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

    private func computeContact(withTriangle triangle: BKPhysicsTriangle) -> BKPhysicsContact? {
        let unitVector = velocity / velocity.length
        let line = BKLine(from: center, to: center + unitVector)
        let nearestEdge = triangle.nearestEdge(to: self.center)

        if let intersectionPoint = line.intersectionPoint(to: nearestEdge) {
            return BKPhysicsContact(bodyA: self, bodyB: triangle, contactPoint: intersectionPoint)
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
        switch body {
        case let edge as BKPhysicsEdge:
            return computeCollisionVector(withEdge: edge)
        case let triangle as BKPhysicsTriangle:
            return computeCollisionVector(withTriangle: triangle)
        default:
            fatalError("Unsupported BKPhysicsBody subclass")
        }
    }

    private func computeCollisionVector(withLine line: BKLineProtocol) -> CGVector {
        // https://math.stackexchange.com/questions/13261/how-to-get-a-reflection-vector
        let lineVector = CGVector(dx: line.to.x - line.from.x, dy: line.to.y - line.from.y)
        let normal1 = lineVector.normalVectors.0
        let normal2 = lineVector.normalVectors.1
        let inverseD = velocity * -1
        let angle1 = acos(inverseD.dot(normal1) / (inverseD.length * normal1.length)) * 180 / CGFloat.pi
        let angle2 = acos(inverseD.dot(normal2) / (inverseD.length * normal2.length)) * 180 / CGFloat.pi

        let normal = angle1 < angle2 ? normal1 : normal2
        let r = CGVector.computeReflectionVector(d: velocity, n: normal / normal.length)
        return r * restitution
    }

    private func computeCollisionVector(withEdge edge: BKPhysicsEdge) -> CGVector {
        computeCollisionVector(withLine: edge)
    }

    private func computeCollisionVector(withTriangle triangle: BKPhysicsTriangle) -> CGVector {
        let edge = triangle.nearestEdge(to: center)
        return computeCollisionVector(withLine: edge)
    }

    func computeCollisionVectors(with body: BKPhysicsBodyWithVolume) -> (CGVector, CGVector) {
        switch body {
        case let circle as BKPhysicsCircle:
            return computeCollisionVectors(withCircle: circle)
        default:
            fatalError("Unsupported BKPhysicsBodyWithVolume subclass")
        }
    }

    private func computeCollisionVectors(withCircle circle: BKPhysicsCircle) -> (CGVector, CGVector) {
        let m1 = mass
        let m2 = circle.mass
        let v1 = velocity
        let v2 = circle.velocity

        if circle.isResting || !circle.isDynamic {
            // Ideal solution: https://en.wikipedia.org/wiki/Elastic_collision#Two-dimensional
            // Problem is that I'm not sure what the angle of deflection in ^ is supposed to be

            // So instead, use this
            // https://math.stackexchange.com/questions/13261/how-to-get-a-reflection-vector
            let v2ToV1 = CGVector(dx: center.x - circle.center.x, dy: center.y - circle.center.y)
            let r = CGVector.computeReflectionVector(d: v1, n: v2ToV1 / v2ToV1.length)
            let dampenedR = r * restitution
            return (dampenedR, .zero)
        }

        // https://en.wikipedia.org/wiki/Elastic_collision#Two-dimensional_collision_with_two_moving_objects
        let x1 = CGVector(dx: center.x, dy: center.y)
        let x2 = CGVector(dx: circle.center.x, dy: circle.center.y)

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
