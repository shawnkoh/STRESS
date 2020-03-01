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

    var edges: [BKLine] {
        [BKLine(from: vertexA, to: vertexB),
         BKLine(from: vertexB, to: vertexC),
         BKLine(from: vertexC, to: vertexA)]
    }

    var centroid: CGPoint {
        .init(x: (vertexA.x + vertexB.x + vertexC.x) / 3,
              y: (vertexA.y + vertexB.y + vertexC.y) / 3)
    }

    func moveCentroidTo(point: CGPoint) {
        // TODO: Make this more general
        let offset = CGVector(dx: point.x - centroid.x, dy: point.y - centroid.y)
        vertexA += offset
        vertexB += offset
        vertexC += offset
    }

    func nearestEdge(to point: CGPoint) -> BKLine {
        guard let edge = edges.min(by: { point.distance(to: $0.midpoint ) < point.distance(to: $1.midpoint) }) else {
            fatalError("Could not access lines")
        }
        return edge
    }
}
