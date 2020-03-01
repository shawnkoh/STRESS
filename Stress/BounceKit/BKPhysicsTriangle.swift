//
//  BKPhysicsTriangle.swift
//  Stress
//
//  Created by Shawn Koh on 1/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

class BKPhysicsTriangle: BKPhysicsBody {
    var vertexA: CGPoint
    var vertexB: CGPoint
    var vertexC: CGPoint

    init(vertexA: CGPoint, vertexB: CGPoint, vertexC: CGPoint) {
        self.vertexA = vertexA
        self.vertexB = vertexB
        self.vertexC = vertexC
    }
}
