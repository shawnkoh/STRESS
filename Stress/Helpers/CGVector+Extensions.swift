//
//  CGVector+Extensions.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

extension CGVector {
    // swiftlint:disable shorthand_operator
    /**
     Adds a vector to another vector.
     */
    static func + (left: CGVector, right: CGVector) -> CGVector {
        CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
    }

    /**
     Substracts a vector from another vector.
     */
    static func - (left: CGVector, right: CGVector) -> CGVector {
        CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
    }

    /**
     Multiplies the vector with a scalar.
     */
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }

    /**
     Multiplies the vector with a scalar.
     */
    static func * (scalar: CGFloat, vector: CGVector) -> CGVector {
        CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }

    /**
     Divides the vector with a scalar.
     */
    static func / (vector: CGVector, scalar: CGFloat) -> CGVector {
        CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
    }

    /**
     Divides the vector with a scalar.
     */
    static func / (scalar: CGFloat, vector: CGVector) -> CGVector {
        CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
    }

    /**
     Increments a CGVector with values from another.
     */
    static func += (left: inout CGVector, right: CGVector) {
        left = left + right
    }

    /**
     Decrements a CGVector with values from another.
     */
    static func -= (left: inout CGVector, right: CGVector) {
        left = left - right
    }

    static func *= (vector: inout CGVector, scalar: CGFloat) {
        vector = vector * scalar
    }

    static func /= (vector: inout CGVector, scalar: CGFloat) {
        vector = vector / scalar
    }

    static func + (point: CGPoint, vector: CGVector) -> CGPoint {
        CGPoint(x: point.x + vector.dx, y: point.y + vector.dy)
    }

    static func - (point: CGPoint, vector: CGVector) -> CGPoint {
        CGPoint(x: point.x - vector.dx, y: point.y - vector.dy)
    }

    static func += (point: inout CGPoint, vector: CGVector) {
        point = point + vector
    }

    static func -= (point: inout CGPoint, vector: CGVector) {
        point = point - vector
    }

    /**
     - Parameters:
        - d: The vector to reflect
        - n: The normal of the surface. It must be normalised
     - Returns: The reflected vector
     */
    static func computeReflectionVector(d: CGVector, n: CGVector) -> CGVector {
        // https://math.stackexchange.com/questions/13261/how-to-get-a-reflection-vector
        d - 2 * (d.dot(n)) * n
    }

    /**
     Calculates the dot product of two vectors.
     */
    func dot(_ vector: CGVector) -> CGFloat {
        dx * vector.dx + dy * vector.dy
    }

    /**
     Calculates the length of a vector.
     */
    var length: CGFloat {
        self.dot(self).squareRoot()
    }

    /// Returns the perpendicular vectors.
    var normalVectors: (CGVector, CGVector) {
        // https://stackoverflow.com/questions/1243614/how-do-i-calculate-the-normal-vector-of-a-line-segment/
        let normalVector1 = CGVector(dx: -dy, dy: dx)
        let normalVector2 = CGVector(dx: dy, dy: -dx)
        return (normalVector1, normalVector2)
    }
}
