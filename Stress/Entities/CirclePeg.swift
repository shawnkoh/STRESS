//
//  CirclePeg.swift
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
class CirclePeg: Peg {
    init(center: CGPoint, type: PegType, radius: CGFloat = Settings.Peg.radius) {
        let circle = BKPhysicsCircle(center: center, radius: radius, isDynamic: false, isResting: false)
        let size = CGSize(width: radius * 2, height: radius * 2)
        let view = PegView(type: type, shape: .circle, size: size)
        super.init(type: type, position: center, view: view, physicsBody: circle)
    }
}

extension CirclePeg: Savable {
    func save() -> Object {
        CirclePegData(peg: self)
    }
}
