//
//  Peg.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit
import RealmSwift

/**
 `Peg` is an entity that represents a peg in Stress.
*/
class Peg: GKEntity {
    init(center: CGPoint, type: PegType, shape: PegShape, radius: CGFloat = Settings.Peg.radius) {
        super.init()

        addComponent(PegComponent(type: type, shape: shape))

        switch type {
        case .orange:
            addComponent(ObjectiveComponent())
        case .green:
            addComponent(SpaceBlastComponent())
        case .red:
            addComponent(SpookyBallComponent())
        case .blue:
            ()
        }

        let score = Settings.Peg.score(for: type)
        addComponent(ScoreComponent(score: score))

        let transformComponent = TransformComponent(position: center)
        addComponent(transformComponent)

        let view = PegView(type: type, shape: shape, radius: radius)
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        switch shape {
        case .circle:
            let circle = BKPhysicsCircle(center: center, radius: radius, isDynamic: false, isResting: false)
            let physicsComponent = PhysicsComponent(physicsBody: circle)
            addComponent(physicsComponent)
        case .triangle:
            let diameter = radius * 2
            let triangle = BKPhysicsTriangle(vertexA: .init(x: radius, y: 0),
                                             vertexB: .init(x: diameter, y: 0),
                                             vertexC: .init(x: 0, y: diameter))
            let physicsComponent = PhysicsComponent(physicsBody: triangle)
            addComponent(physicsComponent)
        }
    }
}

extension Peg: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension Peg: Savable {
    func save() -> Object {
        PegData(peg: self)
    }
}
