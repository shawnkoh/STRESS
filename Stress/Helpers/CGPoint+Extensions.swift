//
//  CGPoint+Extensions.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    /// Calculates the distance between this and another `CGPoint`.
    /// - Parameter to: The point to calculate the distance between.
    /// - Returns: The distance between this and another point.
    public func distance(to: CGPoint) -> CGFloat {
        hypot(x - to.x, y - to.y)
    }

    /**
     Calculates the midpoint between this and another CGPoint.
     */
    func midpoint(to point: CGPoint) -> CGPoint {
        CGPoint(x: (x + point.x) / 2, y: (y + point.y) / 2)
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
