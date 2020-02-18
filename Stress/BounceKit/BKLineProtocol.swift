//
//  BKLineProtocol.swift
//  Bounce
//
//  Created by Shawn Koh on 15/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// The protocol `BKLine` represents a line.
protocol BKLineProtocol {
    var from: CGPoint { get set }
    var to: CGPoint { get set }

    func intersectionPoint(to line: BKLineProtocol) -> CGPoint?
    func shortestDistance(to point: CGPoint) -> CGFloat
}

extension BKLineProtocol {
    /// Calculates the intersection point between two lines.
    func intersectionPoint(to line: BKLineProtocol) -> CGPoint? {
        // swiftlint:disable line_length
        // https://www.topcoder.com/community/competitive-programming/tutorials/geometry-concepts-line-intersection-and-its-applications/
        // swiftlint:enable line_length
        // Line 1
        let x1 = from.x
        let y1 = from.y
        let x2 = to.x
        let y2 = to.y

        let A1 = y2 - y1
        let B1 = x1 - x2
        let C1 = A1 * x1 + B1 * y1

        // Line 2
        let x3 = line.from.x
        let y3 = line.from.y
        let x4 = line.to.x
        let y4 = line.to.y

        let A2 = y4 - y3
        let B2 = x3 - x4
        let C2 = A2 * x3 + B2 * y3

        let determinant = A1 * B2 - A2 * B1

        guard determinant != 0 else {
            // Lines are parallel
            return nil
        }

        let x = (B2 * C1 - B1 * C2) / determinant
        let y = (A1 * C2 - A2 * C1) / determinant

        return CGPoint(x: x, y: y)
    }

    /// Calculates the shortest distance from a line to a point.
    func shortestDistance(to point: CGPoint) -> CGFloat {
        // https://math.stackexchange.com/questions/275529/check-if-line-intersects-with-circles-perimeter
        let x0 = point.x
        let y0 = point.y
        let x1 = from.x
        let y1 = from.y
        let x2 = to.x
        let y2 = to.y

        let a = y1 - y2
        let b = x2 - x1
        let c = (x1 - x2) * y1 + x1 * (y2 - y1)

        return (a * x0 + b * y0 + c).abs() / (a * a + b * b).squareRoot()
    }
}
