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
    init(center: CGPoint, shape: PegShape, isObjective: Bool, radius: CGFloat = StressSettings.defaultPegRadius) {
        super.init()

        addComponent(PegComponent(shape: shape))
        if isObjective {
            addComponent(ObjectiveComponent())
        }
        addComponent(ScoreComponent(score: 100))

        let transformComponent = TransformComponent(position: center)
        addComponent(transformComponent)

        let view = PegView(shape: shape, isObjective: isObjective)
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
