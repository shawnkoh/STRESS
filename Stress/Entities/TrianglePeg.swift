//
//  TrianglePeg.swift
//  Stress
//
//  Created by Shawn Koh on 2/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit
import RealmSwift

/**
 `Peg` is an entity that represents a peg in Stress.
*/
class TrianglePeg: Peg {
    init(vertexA: CGPoint, vertexB: CGPoint, vertexC: CGPoint, type: PegType) {
        let vertices = [vertexA, vertexB, vertexC]
        guard
            let minX = vertices.min(by: { $0.x < $1.x })?.x,
            let minY = vertices.min(by: { $0.y < $1.y })?.y,
            let maxX = vertices.max(by: { $0.x < $1.x })?.x,
            let maxY = vertices.max(by: { $0.y < $1.y })?.y
        else {
            fatalError("Unable to access vertices")
        }
        let size = CGSize(width: maxX - minX, height: maxY - minY)

        let triangle = BKPhysicsTriangle(vertexA: vertexA, vertexB: vertexB, vertexC: vertexC)
        let view = PegView(type: type, shape: .triangle, size: size)
        super.init(type: type, position: triangle.centroid, view: view, physicsBody: triangle)
    }
}

extension TrianglePeg: Savable {
    func save() -> Object {
        TrianglePegData(peg: self)
    }
}
