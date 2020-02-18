//
//  BKPhysicsEdge.swift
//  Bounce
//
//  Created by Shawn Koh on 15/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// An edge between two points.
class BKPhysicsEdge: BKPhysicsBody, BKLineProtocol {
    var from: CGPoint
    var to: CGPoint

    init(from: CGPoint, to: CGPoint) {
        self.from = from
        self.to = to
        super.init()
    }
}
