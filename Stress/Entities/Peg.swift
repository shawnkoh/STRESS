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

        let physicsBody = BKPhysicsCircle(center: center, radius: radius, isDynamic: false, isResting: false)
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody)
        addComponent(physicsComponent)
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
